defmodule Learn.GenWorker do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  #Client API
  def get_temperature(pid, location) do
    GenServer.call(pid, {:location, location})
  end

  #Server API
  def handle_call({:location, location}, _from, state) do
    case temperature_of(location) do
      {:ok, temp} ->
          new_state = update_state(state, location)
          {:reply, "#{temp}", new_state}
      _ ->
          {:reply, :error, state}
    end
  end

  #Helper functions
  defp temperature_of(location) do
    url_for(location) |> HTTPoison.get |> parse_response
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code:200}}) do
    body |> JSON.decode! |> compute_temperature
  end

  def parse_response(_) do
    :error
  end

  defp url_location(location) do
    "http://api.openweathermap.org/data/2.5/weather?p=#{location}&APPID=#{apikey}"
  end

  defp apikey do
    "3bcefb6d7bb84307b0e4eb31a73b03f4"
  end

end
