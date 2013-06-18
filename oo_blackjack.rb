#Magan Adam
#15/06/13
#Encapsulation
require "rubygems"
require "pry"

class Card
  #Create's getter and setter methods for symbols below
  attr_accessor :face, :suite

  #initializes new objects with below attributes
  def initialize(f,s)
    @face = f
    @suite = s
  end

  #pretty output
  def prettify()
    "The #{face} of #{which_suite}"
  end
  #to_s is used to point to prettify the method
  def to_s()
    prettify()
  end

  #find the right suite name
  def which_suite()
    ret_val = case suite
    when "H" then "Heart"
    when "C" then "Club"
    when "D" then "Diamond"
    when "S" then "Spades"
    end
    ret_val
  end
end

class Deck
  attr_accessor :cards
  def initialize()
    @cards = []

    ['S','H','C','D'].each do |suite|
      ['2','3','4','5','6','7','8','9','10','A','K','J','Q'].each do |face|
        @cards << Card.new(face, suite)
      end
    end
    shuffle_cards()
  end
  def shuffle_cards()
    cards.shuffle!
  end
  def deal_card()
    cards.pop
  end
  def size()
    cards.size
  end
end

module Hand
  def add_card(new_card)
    cards << new_card
  end
  def show_hand()
    puts "---#{name}'s hand---"
    cards.each do |card|
      puts "=>#{card.to_s}"
    end
    puts "=> Total: #{calculate_total()}"
  end
  def calculate_total()
    face = cards.map { |e| e.face  }

    total = 0
    face.each do |value|
      if value == 'A'
        total += 11
      elsif value.to_i == 0 #only works for J, Q, K
        total += 10
      else
        total += value.to_i
      end
    end
    #Code to make Aces work
    face.select{|e| e ==  "A"}.count.times do
      total -=10 if total > 21
    end

    if face.include?("A") && total > 21
      total -= 10
    end

    total
  end
  def busted?
    calculate_total > 21
  end
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end
  def show_flop()
    puts "---#{name} hand---"
    puts "=>The first card is hidden"
    puts "=>The second card is #{cards[1]}"
  end

end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize()
    @name = "Dealer"
    @cards = []
  end
  def show_flop()
    puts "---Dealer's hand---"
    puts "=>The first card is hidden"
    puts "=>The second card is #{cards[1]}"
  end

end

class Blackjack
  attr_accessor :deck, :player, :dealer

  def initialize()
    @deck = Deck.new()
    @player = Player.new("Player!")
    @dealer = Dealer.new()
  end
  def start()
    set_player_name()
    deal()
    show_flop()
    player_turn()
    dealer_turn()
    who_won?
  end
  def blackjack_or_bust?(player_or_dealer)
    if player_or_dealer.calculate_total == 21
      if player_or_dealer.is_a?(Dealer)
        puts "The dealer hit Blackjack and wins!"
        else
          puts "Congratulations #{player.name} hit blackjack! You win!"
      end
      exit
    elsif player_or_dealer.busted?
      if player_or_dealer.is_a?(Dealer)
          puts "The dealer busted #{player.name} wins"
      else
          puts "#{player.name} busted and loses"
      end
      exit
    end
  end
  def player_turn()
    puts "#{player.name}'s turn"

    blackjack_or_bust?(player)

    until player.busted?
      puts "What would you like to do #{player.name}? 1) hit 2) stay"
      response = gets.chomp
      unless ['1', '2'].include?(response)
        puts "Error: You must enter either 1 or 2!!"
        next
      end
      if response == '2'
        puts "#{player.name} chooses to stay"
        break
      end

      #chooses to hit
      new_card = deck.deal_card()
      puts "Dealing card #{new_card} to #{player.name}; "
      player.add_card(new_card)
      puts "#{player.name()}'s total is now #{player.calculate_total()}"
      blackjack_or_bust?(player)
    end
    puts "#{player.name}'s total is #{player.calculate_total()}"
  end
  def dealer_turn()
    puts "Dealer's turn"
    blackjack_or_bust?(dealer)
    while dealer.calculate_total() < 17
      new_card = deck.deal_card()
      puts "Dealing card #{new_card}to dealer"
      dealer.add_card(new_card)
      puts "Dealer total is now #{dealer.calculate_total}"
      blackjack_or_bust?(dealer)
    end
    puts "The dealer stays at #{dealer.calculate_total()}"
  end
  def set_player_name()
    puts "Please enter your name below"
    player.name = gets.chomp
  end
  def deal()
    player.add_card(deck.deal_card())
    dealer.add_card(deck.deal_card())
    player.add_card(deck.deal_card())
    dealer.add_card(deck.deal_card())
  end
  def show_flop()
    player.show_flop()
    dealer.show_flop()
  end
  def who_won?
    #Declare a winner
    if player.calculate_total > dealer.calculate_total
      puts "The #{player.name()}"
    elsif dealer.calculate_total > player.calculate_total
      puts "The Dealer wins"
    else
      puts "sorry its a tie"
    end
    exit
  end
end
game = Blackjack.new()
game.start
