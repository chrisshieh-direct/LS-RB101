require 'yaml'
require 'pry'

RANKS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
SUITS = ['C', 'H', 'S', 'D']
VALUES = { 'A' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
           '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10,
           'Q' => 10, 'K' => 10 }

def display_table(dlr, plr)
  system 'clear'
  puts "---===Welcome to BLACKJACK!===---\n\n"
  puts "DEALER HAND: #{show_card(dlr[0])} (hidden)"
  puts "---------------------------------"
  puts "YOUR HAND: #{show_hand(plr)}"
  puts "Total: #{total(plr)}"
end

def new_shuffled_deck
  fresh_deck = []
  SUITS.each do |suit|
    RANKS.each do |rank|
      fresh_deck << [rank, suit]
    end
  end
  fresh_deck.shuffle
end

def total(cards)
  sum = 0
  cards.each do |arr|
    value = VALUES[arr[0]]
    sum += value
  end
  i = cards.flatten.count('A')
  while i > 0
    break if sum < 22
    sum -= 10
    i -= 1
  end
  sum
end

def show_hand(arr)
  display = ''
  arr.each do |a|
    display << show_card(a) + ' '
  end
  display
end

def show_card(arr)
  (arr[0] + arr[1]).to_s
end

def think
  10.times do
    print '.'
    sleep rand / 5
  end
end

def bust?(who)
  total(who) > 21
end

def dealer_move(dlr)
  total(dlr) < 17 ? 'h' : 's'
end
# END METHODS

# MAIN GAME
deck = new_shuffled_deck

player = deck.shift(2)
dealer = deck.shift(2)

display_table(dealer, player)

loop do
  loop do
    puts "\n(H)it or (S)tay?"
    choice = gets.chomp.downcase

    if choice == 'h'
      player << deck.shift.flatten
      display_table(dealer, player)
      puts "New card is #{show_card(player.last)}."
    else
      puts "You stay."
      break
    end

    puts "Player total: " + total(player).to_s
    if bust?(player)
      puts "You busted."
      break
    end
  end

  if bust?(player)
    puts "You busted. Play again?"
    break
  else
    puts "You stayed with a total of #{total(player)}."
  end

  puts "Dealer deciding..."
  think
  if dealer_move(dealer) == 'h'
    dealer << deck.shift.flatten
    puts "Dealer draws #{show_card(dealer.last)}."
  else
    puts "Dealer stays."
  end
  puts "Dealer total: " + total(dealer).to_s
  puts "Dealer busted." if bust?(dealer)

  msg = total(player) > total(dealer) ? "You win." : "Dealer wins."
  puts msg

  puts "Play again?"
  again = gets.chomp.downcase
  break if again == 'n'
end
