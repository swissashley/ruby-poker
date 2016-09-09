class Game
  attr_accessor :deck, @player_list

  def initialize(deck, *players)
    @deck = deck
    @player_list = []
    players.each do |player|
      @player_list << player
    end
    deal_cards_to_players
  end

  def play
    @player_list.each_with_index do |player, idx|
      puts "Player #{(idx+1)}:"
      player.discard_card
      player.render
    end
    @player_list.each_with_index do |player, idx|
      until player.player_hand.count == 5
        player.player_hand.add_card_to_hand(@deck.deal_hand)
      end
    end
    @player_list.each_with_index do |player, idx|
      player.render
      puts "Player #{(idx+1)}"
      player.fold_see_or_raise
      # to be finished
    end




  end

  def deal_cards_to_players
    @player_list.each do |player|
      5.times do |i|
        player.add_card_to_hand(@deck.deal_hand)
      end
    end
  end

  def player_turn

  end

end

if __FILE__ == $PROGRAM_NAME
  deck = Deck.new

  hand1 = Hand.new
  player1 = Player.new(hand1, 1000)

  hand2 = Hand.new
  player2 = Player.new(hand2, 800)

  game = Game.new(deck, player1, player2)
  game.play
end
