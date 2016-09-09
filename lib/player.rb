class Player
  attr_accessor :player_hand, :pot, :wallet

  def initialize(hand, initial_cash)
    @player_hand = hand
    @pot = 0
    @wallet = initial_cash
  end

  def discard_card
    puts "Would you like to discard any cards? [0..4]"
    puts "Press 9 if you don't want to discard"
    user_input = gets.chomp
    if user_input != "9"
      drop_card = @player_hand[user_input]
      @player_hand.drop_card(drop_card)
    end
  end

  #ask about fold, see or raise
  def fold_see_or_raise
    user_input = ""
    while user_input != "f" || user_input != "s" || user_input !=  "r"
      puts "Would you like to FOLD, SEE or RAISE (f, s, r)"
      user_input = gets.chomp.downcase
    end
    user_input
  end

  def render
    system("clear")
    puts "Current cash: #{@wallet}, current pot: #{@pot}"
    puts "Current hand: #{@player_hand}"
  end

end
