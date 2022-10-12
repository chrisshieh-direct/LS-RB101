require 'yaml'
require 'pry'

# CONSTANTS
RANKS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
SUITS = ['C', 'H', 'S', 'D']
VALUES = { 'A' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
           '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10,
           'Q' => 10, 'K' => 10 }

# BEGIN METHODS
def display_table(dlr, plr, hide = 0)
  dealer_display = if hide == 1
                     "DEALER HAND: #{show_card(dlr[0])} (hidden)"
                   else
                     "DEALER HAND: #{show_hand(dlr)} | TOTAL: #{total(dlr)}"
                   end

  system 'clear'
  puts "---===Welcome to BLACKJACK!===---\n\n"
  puts dealer_display
  puts "---------------------------------"
  puts "YOUR HAND: #{show_hand(plr)} | TOTAL: #{total(plr)}"
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
  12.times do
    print '.'
    sleep rand / 7
  end
end

def blackjack?(cards)
  total(cards) == 21
end

def bust?(who)
  total(who) > 21
end

def dealer_move(dlr)
  total(dlr) < 17 ? 'h' : 's'
end

def play_again?
  again = ''
  puts "\nPlay again? Y or N."
  loop do
    again = gets.chomp.downcase
    if again == 'y' || again == 'n'
      break
    else
      puts "Sorry, enter Y or N."
    end
  end
  again == 'y'
end

def determine_winner(dlr, plr)
  total(dlr) <=> total(plr)
end

def display_winner(wnr)
  case wnr
  when 1
    puts "The dealer won."
  when 0
    puts "It's a push."
  when -1
    puts "You won! Congratulations!"
  end
end
# END METHODS

# MAIN GAME LOOP
loop do
  print "Shuffling and dealing..."
  think

  deck = new_shuffled_deck

  player = deck.shift(2)
  dealer = deck.shift(2)

  display_table(dealer, player, 1)

  if blackjack?(player)
    puts "\nWOW! You got a BLACKJACK! You win!"
    play_again? ? next : break
  end

  # PLAYER TURN MOVE TO HELPER METHOD
  loop do
    puts "\n(H)it or (S)tay?"
    choice = gets.chomp.downcase

    if choice == 'h'
      player << deck.shift.flatten
      display_table(dealer, player, 1)
      puts "New card is #{show_card(player.last)}."
    else
      puts "You stay."
      break
    end

    puts "Player total: " + total(player).to_s

    break if bust?(player)
    break if player.length == 5
  end

  if bust?(player)
    puts "You busted with #{total(player)}. You lose."
    play_again? ? next : break
  end

  if player.length == 5
    puts "You got a 5-Card Charlie! You WIN!"
    play_again? ? next : break
  end

  display_table(dealer, player)

  # DEALER TURN MOVE TO HELPER METHOD
  loop do
    print "Dealer deciding..."
    think
    if dealer_move(dealer) == 'h'
      dealer << deck.shift.flatten
      puts "Dealer draws #{show_card(dealer.last)}."
    else
      puts "Dealer stays."
      break
    end
    sleep 1.5
    display_table(dealer, player)

    break if bust?(dealer)
  end

  if bust?(dealer)
    puts "The dealer busted with #{total(dealer)}. You win!"
    play_again? ? next : break
  end

  display_table(dealer, player)
  puts "Dealer total: " + total(dealer).to_s

  winner = determine_winner(dealer, player)
  display_winner(winner)

  break unless play_again?
end

puts "Thank you for playing!"
