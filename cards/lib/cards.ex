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
end
