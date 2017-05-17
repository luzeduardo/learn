defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> build_grid
  end

  def hash_input(input) do
    hex_data = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex_data}
  end

  @doc """
    This will pattern match the parameter against Identicon Image struct to decide it is ok
    and then chunk the hex data that is a list
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    # |> mirrow_row
  end

  def mirror_row do

  end

  @doc """
    It will take the image hash list
    With the pattern match get the first 3 itens and ignore the rest of the list
    And the method will pattern match the parameter received
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end
end
