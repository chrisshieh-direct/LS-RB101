# CONSTANTS
RANKS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
SUITS = ['C', 'H', 'S', 'D']
VALUES = { 'A' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
           '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10,
           'Q' => 10, 'K' => 10 }
WINNING_TOTAL = 21
DEALER_MUST_HOLD_AT = 17

# BEGIN METHODS
def display_table(dlr, plr, totals_local, dlr_card = 'show')
  dealer_display = if dlr_card == 'hide'
                     "DEALER HAND: #{show_card(dlr[0])} (hidden)"
                   else
                     "DEALER HAND: #{show_hand(dlr)} | TOTAL: #{totals_local[:dealer]}"
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
  i = cards.flatten.count('A')
  while i > 0
    break if sum < (WINNING_TOTAL + 1)
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

def player_turn(player_local, totals_local, dealer_local, deck_local)
  loop do
    puts "\n(H)it or (S)tay?"
    choice = gets.chomp.downcase

    if choice == 'h'
      player_local << deck_local.shift.flatten
      totals_local[:player] = total(player_local)
      display_table(dealer_local, player_local, totals_local, 'hide')
      puts "New card is #{show_card(player_local.last)}."
      puts "\nYour total: " + totals_local[:player].to_s
      break if bust?(totals_local[:player])
      break if player_local.length == 5
    else
      puts "You stay."
      puts "\nYour total: " + totals_local[:player].to_s
      break
    end
  end
end

def dealer_turn(player_local, totals_local, dealer_local, deck_local)
  loop do
    print "Dealer deciding..."
    think
    if dealer_move(dealer_local) == 'h'
      dealer_local << deck_local.shift.flatten
      puts "Dealer draws #{show_card(dealer_local.last)}."
      totals_local[:dealer] = total(dealer_local)
      break if bust?(totals_local[:dealer])
    else
      puts "Dealer stays."
      break
    end
    sleep 1.5
    display_table(dealer_local, player_local, totals_local)
  end
end
# END METHODS

# MAIN GAME LOOP
loop do
  system 'clear'
  print "Shuffling and dealing..."
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
    puts "You BUSTED. You lose."
    play_again? ? next : break
  end

  if player.length == 5
    puts "You got a 5-Card Charlie! You WIN!"
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
