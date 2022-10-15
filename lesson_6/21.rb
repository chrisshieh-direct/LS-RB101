require 'io/console'
require 'pry'

# CONSTANTS
RANKS = ['Ace', '2', '3', '4', '5', '6', '7',
         '8', '9', '10', 'Jack', 'Queen', 'King']
SUITS = ['Clubs', 'Hearts', 'Spades', 'Diamonds']
VALUES = { 'Ace' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
           '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'Jack' => 10,
           'Queen' => 10, 'King' => 10 }
WINNING_TOTAL = 21
DEALER_MUST_HOLD_AT = 17

# BEGIN METHODS
def display_table(dlr, plr, totals_local, dlr_card = 'show')
  dealer_display = if dlr_card == 'hide'
                     "DEALER HAND: #{show_card(dlr[0])} (hidden)"
                   else
                     "DEALER HAND: #{show_hand(dlr)} | TOTAL: "\
                     "#{totals_local[:dealer]}"
                   end

  system 'clear'
  puts "---===Welcome to BLACKJACK!===---\n\n"
  puts dealer_display
  puts "---------------------------------"
  puts "YOUR HAND: #{show_hand(plr)} | TOTAL: #{totals_local[:player]}\n\n"
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
  i = cards.flatten.count('Ace')
  while i > 0
    break if sum < (WINNING_TOTAL + 1)
    sum -= 10
    i -= 1
  end
  sum
end

def show_hand(arr)
  display = ''
  *most, last = arr
  most.each do |card|
    display << show_card(card) + ', '
  end
  display << show_card(last)
end

def show_card(arr)
  (arr[0] + ' of ' + arr[1]).to_s
end

def think
  12.times do
    print '.'
    sleep rand / 7
  end
end

def blackjack?(player_total_local)
  player_total_local == WINNING_TOTAL
end

def bust?(total_local)
  total_local > WINNING_TOTAL
end

def dealer_move(dlr)
  total(dlr) < DEALER_MUST_HOLD_AT ? 'h' : 's'
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

def determine_winner(totals_local)
  totals_local[:dealer] <=> totals_local[:player]
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

def hit_or_stay
  puts "\n(H)it or (S)tay?"
  answer = ''
  loop do
    answer = gets.chomp.downcase
    break if ['h', 's', 'hit', 'stay'].include?(answer)
    puts "Sorry, please choose (H)it or (S)tay."
  end
  answer
end

def player_hit(player_local, dealer_local, deck_local, totals_local)
  player_local << deck_local.shift.flatten
  totals_local[:player] = total(player_local)
  display_table(dealer_local, player_local, totals_local, 'hide')
  puts "New card is #{show_card(player_local.last)}."
end

def player_turn(player_local, totals_local, dealer_local, deck_local)
  loop do
    choice = hit_or_stay
    if choice == 'h' || choice == 'hit'
      player_hit(player_local, dealer_local, deck_local, totals_local)
      break if bust?(totals_local[:player]) || player_local.length == 5
    else
      puts "You stay."
      puts "\nYour total: " + totals_local[:player].to_s
      break
    end
  end
end

def dealer_turn(player_local, totals_local, dealer_local, deck_local)
  print "Dealer deciding..."
  think
  if dealer_move(dealer_local) == 'h'
    dealer_local << deck_local.shift.flatten
    puts "Dealer draws #{show_card(dealer_local.last)}."
    totals_local[:dealer] = total(dealer_local)
    continue
    display_table(dealer_local, player_local, totals_local)
    return if bust?(totals_local[:dealer])
    dealer_turn(player_local, totals_local, dealer_local, deck_local)
  else
    puts "Dealer stays."
    continue
  end
end

def introduction
  puts "Would you like to an introduction to the game? (Y or N)"
  answer = ''
  loop do
    answer = gets.chomp.downcase
    break if answer == 'y' || answer == 'n'
    puts "Sorry, please enter Y or N."
  end
  return if answer == 'n'
  puts "In Blackjack, you will be dealt two cards, with the option to 'hit' to"
  puts "receive more cards, or 'stay' if you are satisfied with your total."
  puts "Your goal is to get as close to #{WINNING_TOTAL} without going over,"
  puts "and you win if your total is higher than the dealer's. You can also"
  puts "win by accumulating five cards, which is called a 5-Card Charlie."
  puts "-------------------------------------------------------------------"
  continue
end

def continue
  puts "\nPress any key to continue."
  STDIN.getch
end
# END METHODS

# MAIN GAME LOOP
system 'clear'
introduction

loop do
  print "\nShuffling and dealing..."
  think

  deck = new_shuffled_deck
  player = deck.shift(2)
  dealer = deck.shift(2)

  totals = { player: 0, dealer: 0 }
  totals[:player] = total(player)
  totals[:dealer] = total(dealer)

  display_table(dealer, player, totals, 'hide')

  if blackjack?(totals[:player])
    puts "\nWOW! You got a BLACKJACK! You win!"
    play_again? ? next : break
  end

  player_turn(player, totals, dealer, deck)

  if bust?(totals[:player])
    puts "\nYou BUSTED. You lose."
    play_again? ? next : break
  end

  if player.length == 5
    puts "\nYou got a 5-Card Charlie! You WIN!"
    play_again? ? next : break
  end

  display_table(dealer, player, totals)

  dealer_turn(player, totals, dealer, deck)

  if bust?(totals[:dealer])
    puts "The dealer busted with #{totals[:dealer]}. You win!"
    play_again? ? next : break
  end

  display_table(dealer, player, totals)

  puts "Dealer total: " + totals[:dealer].to_s

  winner = determine_winner(totals)
  display_winner(winner)

  break unless play_again?
end

puts "Thank you for playing!"
