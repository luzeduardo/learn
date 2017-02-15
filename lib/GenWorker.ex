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

end
