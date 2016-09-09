require 'byebug'
class Hand

  FACE_VALUE = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  SUIT = {:spade => 0, :heart => 1, :diamond => 2, :club => 3}

  POKER_SETS = {
    "Royal Flush" => 1, "Straight Flush" => 2, "Four-of-a-Kind" => 3,
    "Full House" => 4, "Flush" => 5, "Straight" => 6,
    "Three-of-a-Kind" => 7, "Two Pair" => 8, "One Pair" => 9,
    "No Pair" => 10
  }

  attr_reader :hand

  def initialize
    @hand = []
  end

  def add_card_to_hand(card)
    @hand << card
  end

  def drop_card(card)
    @hand.delete(card)
  end

  def calculate_hand
    suit_hash = Hash.new {0}
    value_hash = Hash.new {0}
    @hand.each do |hand_card|
      suit_hash[hand_card.suit] += 1 # suit_hash = {:club => 3, :heart => 1}
      value_hash[hand_card.face_value] += 1 # value_hash = {"A" => 1, "K"=>2}
    end
    return [suit_hash, value_hash]

  end

  def straight?

    value_index = @hand.map {|card| FACE_VALUE.index(card.face_value) } # [2,5,5,5,7]
    # byebug
    value_index.sort!
    value_index.uniq!
    return value_index.length == 5 && value_index.last - value_index.first == 4
  end

  def four_of_a_kind?
    calced_hand = calculate_hand
    calced_hand.last.has_value?(4)
  end

  def three_of_a_kind?
    calced_hand = calculate_hand
    calced_hand.last.has_value?(3)
  end

  def two_pair?
    calced_hand = calculate_hand
    calced_hand.last.length == 3
  end

  def one_pair?
    calced_hand = calculate_hand
    calced_hand.last.length == 4
  end

  def flush?
    calced_hand = calculate_hand
    calced_hand.first.length == 1
  end

  def not_flush_and_no_pair?
    calced_hand = calculate_hand
    calced_hand.last.length == 5 && !flush?
  end

  def royal_flush?
    calced_hand = calculate_hand
    flush? && straight? && calced_hand.last.has_key?("A")
  end

  def beats_another_hand?(another_hand)
    raise "Get Ranking Error" if get_ranking == 99 || another_hand.get_ranking == 99
    if get_ranking < another_hand.get_ranking
      return true
    elsif get_ranking > another_hand.get_ranking
      return false
    elsif high_card > another_hand.high_card
      return true
    else
      return false
    end
  end

  def high_card
    @hand.map {|card| FACE_VALUE.index(card.face_value) }.max # [2,5,5,5,7]
  end

  def get_ranking
    if royal_flush?
      return POKER_SETS["Royal Flush"]
    elsif straight? && flush?
      return POKER_SETS["Straight Flush"]
    elsif four_of_a_kind?
      return POKER_SETS["Four-of-a-Kind"]
    elsif three_of_a_kind? && one_pair?
      return POKER_SETS["Full House"]
    elsif flush?
      return POKER_SETS["Flush"]
    elsif straight?
      return POKER_SETS["Straight"]
    elsif three_of_a_kind?
      return POKER_SETS["Three-of-a-Kind"]
    elsif two_pair?
      return POKER_SETS["Two Pair"]
    elsif one_pair?
      return POKER_SETS["One Pair"]
    elsif not_flush_and_no_pair?
      return POKER_SETS["No Pair"]
    end
    return 99
  end
end
