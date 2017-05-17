defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck_20_cards" do
    assert length(Cards.create_deck) == 20
  end

  test "shuffle deck" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)  
  end
end
