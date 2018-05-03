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
    and then map this row with 3 items to mount the mirrored row
    ex.: [1,2,3,4,5,6]
    After Enum.chunk ->  [[1,2,3],[4,5,6] ...]
    After Enum.map(&mirror_row/1) [[1,2,3,2,1],[4,5,6,5,4]]
    After List.flatten -> [1,2,3,2,1,4,5,6,5,4]
    After Enum.with_index -> [{1,0},{2,1},{3,2},{2,3},{1,3} ...]
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
    |> List.flatten
    |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second, _tail] = row
    row ++ [second, first]
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
