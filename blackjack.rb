#Magan Adam
#06/06/2013
#Version 5 or my fourth iteration
#The comments through out this code are there to
#assist me in the near future as I am a beginner in Ruby

def calculate_total(cards)
	arr = cards.map { |e| e[1]  }

	total = 0
	arr.each do |value|
		if value == 'A'
			total += 11
		elsif value.to_i == 0 #only works for J, Q, K
			total += 10
		else
			total += value.to_i
		end
	end
	#Code to make Aces work
	arr.select{|e| e ==  "A"}.count.times do
		total -=10 if total > 21
	end

	if arr.include?("A") && total > 21
		total -= 10
	end

	total
end

#Get the players name and store it in a variable
puts 'Hi and welcome to blackjack'
puts 'Today we are going to play a game of blackjack'
puts 'But before we start Please enter your name'
name = gets.chomp
#Create an array to store the face values and the suite values
face = ['2','3','4','5','6','7','8','9','10','A','K','J','Q']
suites = ['S','H','C','D']
#Now create a new array to store the full cards
cards = []
#To access each object within the suites array use the .each method
suites.each do |current_suite|
	face.each do |current_face|
		cards << [current_suite, current_face]
	end
end

#Now am going to shuffle my cards
cards.shuffle!

#Deal the cards to both player and the dealer two times
my_cards = []
dealer_cards = []

2.times do
	my_cards << cards.pop
	dealer_cards << cards.pop
end

#Store the total for both the player and the dealer
my_total = calculate_total(my_cards)
dealer_total = calculate_total(dealer_cards)

#Show Cards
puts "#{name} cards are: #{my_cards[0]} and #{my_cards[1]} and the total is: #{my_total}"
puts "Dealers cards are: #{dealer_cards[0]} and #{dealer_cards[1]} and the total is: #{dealer_total}"
puts " "


# If player gets blackjack
if my_total == 21
  puts "Congratulations #{name}, you hit blackjack! You win!"
  exit
end

#Execute this if the total for the player is less then 21
while my_total < 21
  puts "What would you like to do #{name}? 1) hit 2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error: you must enter 1 or 2"
    next
  end
  #Do this if player chooses stay
  if hit_or_stay == "2"
    puts "You chose to stay."
    break
  end

  #Do this if player chooses hit
  new_card = cards.pop
  puts "Dealing card to player: #{new_card}"
  my_cards << new_card
  my_total = calculate_total(my_cards)
  puts "#{name} your total is now: #{my_total}"

  if my_total == 21
    puts "Congratulations #{name}, you hit blackjack! You win!"
    exit
  elsif my_total > 21
    puts "Sorry, it looks like you busted!"
    exit
  end
end

#Declare a winner
if dealer_total > my_total
	puts 'The Dealer wins'
else
	puts "#{name} win"
end