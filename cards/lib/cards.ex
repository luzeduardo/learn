defmodule Cards do

  def create_deck do
    values = ["Ace", "Two", "Three","Four","Five"]
    suits = ["Spades","Clubs","Hearts","Diamonds"]

    #instead of using List.flatten() with a for inside for you can use this kind of comprehension
    #that results in the same way
    for suit <- suits, value <- values  do
        "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def deal(deal, hand_size) do
    Enum.split(deal, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    {status, binary_data} = File.read(filename)
    case status do
      :ok -> :erlang.binary_to_term binary_data
      :error -> "File does not exist"
    end
  end

end
