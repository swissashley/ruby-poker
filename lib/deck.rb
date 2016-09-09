class Deck

  FACE_VALUE = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  SUIT = {:spade => 0, :heart => 1, :diamond => 2, :club => 3}

  def initialize
    generate_cards
    shuffle_deck!
  end

  def generate_cards
    @cards = []
    SUIT.each do |suit, num|
      FACE_VALUE.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end

  def shuffle_deck!
    @cards.shuffle!
  end

  def get_cards
    @cards
  end

  
  def include_card?(card_check)
    @cards.each do |card|
      return true if card.face_value == card_check.face_value &&
        card.suit == card_check.suit
    end
    false
  end

  def length
    @cards.length
  end

  def deal_hand
    @cards.pop
  end

  def reset_deck
    generate_cards
    shuffle_deck!
  end

end
