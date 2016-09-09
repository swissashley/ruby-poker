require 'rspec'
require 'hand'

describe Hand do
  let(:hand) { Hand.new }
  let(:card) { Card.new(10, :club )}

  describe "#add_card_to_hand" do
    it "adds a card to the hand" do
      hand.add_card_to_hand(card)
      expect(hand.hand).to eq([card])
    end

    it "drops a card from hand" do
      hand.add_card_to_hand(card)
      hand.drop_card(card)
      expect(hand.hand).to be_empty
    end

  end

  describe "#check card's composition" do
    let(:hand1) { Hand.new }
    let(:card1) { Card.new("10",:club) }
    let(:card2) { Card.new("J",:club) }
    let(:card3) { Card.new("Q",:club) }
    let(:card4) { Card.new("K",:club) }
    let(:card5) { Card.new("A",:club) }
    before(:each) do
      hand1.add_card_to_hand(card1)
      hand1.add_card_to_hand(card2)
      hand1.add_card_to_hand(card3)
      hand1.add_card_to_hand(card4)
      hand1.add_card_to_hand(card5)
    end

    it "should return straight" do
      expect(hand1.straight?).to be true
    end

    it "should return royal flush" do
      expect(hand1.royal_flush?).to be true
    end

    it "should not be a full house" do
      expect(hand1.three_of_a_kind?&&hand1.one_pair?).to be false
    end

    it "should not be a not-flush and no-pair" do
      expect(hand1.not_flush_and_no_pair?).to be false
    end

    it "should return a ranking of 1" do
      expect(hand1.get_ranking).to eq(1)
    end
  end

  describe "#check card's composition" do
    let(:hand1) { Hand.new }
    let(:card1) { Card.new("10",:club) }
    let(:card2) { Card.new("10",:spade) }
    let(:card3) { Card.new("10",:heart) }
    let(:card4) { Card.new("2",:club) }
    let(:card5) { Card.new("4", :spade) }
    before(:each) do
      hand1.add_card_to_hand(card1)
      hand1.add_card_to_hand(card2)
      hand1.add_card_to_hand(card3)
      hand1.add_card_to_hand(card4)
      hand1.add_card_to_hand(card5)
    end

    describe "#three_of_a_kind" do
      it "should return true of Three-of-a-Kind" do
        expect(hand1.three_of_a_kind?).to be true
      end

      it "should return a ranking of 7" do
        expect(hand1.get_ranking).to eq(7)
      end
    end
  end

  describe "#check card's composition" do
    let(:hand1) { Hand.new }
    let(:card1) { Card.new("A",:club) }
    let(:card2) { Card.new("10",:spade) }
    let(:card3) { Card.new("7",:heart) }
    let(:card4) { Card.new("3",:club) }
    let(:card5) { Card.new("4", :spade) }
    before(:each) do
      hand1.add_card_to_hand(card1)
      hand1.add_card_to_hand(card2)
      hand1.add_card_to_hand(card3)
      hand1.add_card_to_hand(card4)
      hand1.add_card_to_hand(card5)
    end

    describe "#high_card" do
      it "should return the No Pair ranking 10" do
        expect(hand1.get_ranking).to eq(10)
      end
      it "should return 12 for Ace" do
        expect(hand1.high_card).to eq(12)
      end
    end
  end

  describe "#beat another hand" do
    let(:hand1) { Hand.new }
    let(:card1) { Card.new("A",:club) }
    let(:card2) { Card.new("10",:spade) }
    let(:card3) { Card.new("7",:heart) }
    let(:card4) { Card.new("3",:club) }
    let(:card5) { Card.new("4", :spade) }

    let(:hand2) { Hand.new }
    let(:card6) { Card.new("K",:club) }
    let(:card7) { Card.new("9",:spade) }
    let(:card8) { Card.new("5",:heart) }
    let(:card9) { Card.new("2",:club) }
    let(:card10) { Card.new("3", :spade) }

    let(:card11) { Card.new("3", :club) }

    before(:each) do
      hand1.add_card_to_hand(card1)
      hand1.add_card_to_hand(card2)
      hand1.add_card_to_hand(card3)
      hand1.add_card_to_hand(card4)
      hand1.add_card_to_hand(card5)

      hand2.add_card_to_hand(card6)
      hand2.add_card_to_hand(card7)
      hand2.add_card_to_hand(card8)
      hand2.add_card_to_hand(card9)
      hand2.add_card_to_hand(card10)
    end


    it "compares if we beat another hand" do
      expect(hand1.beats_another_hand?(hand2)).to be true
    end

    it "should return the one Pair ranking 9" do
      hand2.drop_card(card6)
      hand2.add_card_to_hand(card11)
      expect(hand2.get_ranking).to eq(9)
    end

    it "compares if no pair loses to one pair" do
      hand2.drop_card(card6)
      hand2.add_card_to_hand(card11)
      p hand2
      expect(hand1.beats_another_hand?(hand2)).to be false
    end

  end

end
