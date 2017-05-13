defmodule Cards do

  def create_deck do
    ["Ace", "Two", "Three","Four","Five"]
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end
end
