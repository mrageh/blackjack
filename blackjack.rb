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
#Now create a new array to store the full deck
cards = []
#To access each object within the suites array use the .each method
suites.each do |current_suite|
	face.each do |current_face|
		cards << [current_suite, current_face]
	end
end

#Now am going to shuffle my cards
cards.shuffle!

#Deal the cards to both player and the dealer
mycards = []
dealercards = []
2.times do
	mycards << cards.pop
	dealercards << cards.pop
end

my_total = calculate_total(mycards)
dealer_total = calculate_total(dealercards)

#Show Cards
puts "#{name} cards are: #{mycards[0]} and #{mycards[1]} and the total is: #{my_total}"
puts "Dealers cards are: #{dealercards[0]} and #{dealercards[1]} and the total is: #{dealer_total}"
puts " "

#Declare a winner
if dealer_total > my_total
	puts 'The Dealer wins'
else
	puts "#{name} win"
end

#Prompt user to stay or hit
puts "What would you like to do?? 1.)stay or 2.)hit"
hit_or_stay = gets.chomp