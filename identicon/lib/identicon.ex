defmodule Identicon do
  def main(input) do
    input |> hash_input
  end

  def hash_input(input) do
    hex_data = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Image.Image{hex: hex_data}
  end
end
