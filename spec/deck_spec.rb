require 'rspec'
require 'deck'

describe "Deck" do

  let(:deck) { Deck.new }
  let(:card1) { Card.new(10, :club)}

  describe "#checking length" do
    it "has 52 cards" do
        expect(deck.length).to eq(52)
    end
  end

  # cards are uniq
  describe "#generate_cards" do
    it "includes" do
      card_check = deck.get_cards
      expect(card_check.uniq.length).to eq(52)
    end
  end

  # shuffle
  describe "#checking shuffle" do
    it "shuffles" do
      before_shuffle = deck.get_cards.dup
      deck.shuffle_deck!
      after_shuffle = deck.get_cards
      expect(after_shuffle).to_not eq(before_shuffle)
    end
  end

end
