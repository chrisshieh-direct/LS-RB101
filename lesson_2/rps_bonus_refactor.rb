VALID_CHOICES = %w[rock paper scissors lizard spock]
WINNING_MOVES = {
  rock: [['scissors', 'crushed'], ['lizard', 'crushed']],
  lizard: [['paper', 'ate'], ['spock', 'poisoned']],
  spock: [['rock', 'vaporized'], ['scissors', 'smashed']],
  scissors: [['lizard', 'decapitated'], ['paper', 'cut']],
  paper: [['rock', 'covered'], ['spock', 'disproved']]
}

stats = {
  total_rounds: 0,
  wins: 0,
  losses: 0,
  ties: 0,
  win_pct: 0,
  rounds: 0,
  computer_rounds: 0,
  match_wins: 0,
  computer_match_wins: 0
}
p stats

# Methods
def prompt(str)
  puts ">> #{str}"
end

def check_for_tie(player, computer, hash)
  tie = false
  if player == computer
    prompt("You both chose #{player.upcase}! You tied!")
    hash[:ties] += 1
    hash[:total_rounds] += 1
    tie
  end
end

def win?(first, second, index)
  WINNING_MOVES[first.to_sym][index][0] == second
end

def check_for_match_win(hash)
  if hash[:rounds] == 3
    prompt("============== <<")
    prompt("You won this match, #{hash[:rounds]}-#{hash[:computer_rounds]}!")
    hash.update(rounds: 0)
    hash.update(computer_rounds: 0)
    hash[:match_wins] += 1
  elsif hash[:computer_rounds] == 3
    prompt("============== <<")
    prompt("Aw, the computer won this match, #{hash[:computer_rounds]}" \
      "-#{hash[:rounds]}.")
    hash.update(rounds: 0)
    hash.update(computer_rounds: 0)
    hash[:computer_match_wins] += 1
  end
end

def welcome_stats(hash)
  if hash[:total_rounds] > 0
    prompt("You've played #{hash[:total_rounds]} times, winning " \
      "#{hash[:wins]} rounds, losing #{hash[:losses]} rounds, " \
      "and you tied #{hash[:ties]} times.")
    win_pct = (hash[:wins].to_f / hash[:total_rounds].to_f) * 100
    prompt("Your winning percentage is #{win_pct.round(2)}%")
    prompt("You've won #{hash[:match_wins]} matches and the computer has " \
      "won #{hash[:computer_match_wins]}.")
  end
end

def play_again?
  yesno = ''
  loop do
    prompt("Would you like to play again? (Y/N)")
    yesno = gets.chomp.downcase
    validyesno = %w[yes no y n]
    if validyesno.include?(yesno)
      break
    else
      prompt("That's not a valid choice. Please pick Y or N.")
    end
  end
  %w(y yes).include?(yesno)
end

# Main Game Loop
loop do
  system('clear')
  prompt('Welcome to RPSLS!')

  welcome_stats(stats)

  choice = ''

  loop do
    prompt('Choose (R)ock, (P)aper, (S)cissors, (L)izard, or Spoc(K)!')
    choice = gets.chomp.downcase
    case choice.downcase
    when 'r' then choice = 'rock'
    when 'p' then choice = 'paper'
    when 's' then choice = 'scissors'
    when 'l' then choice = 'lizard'
    when 'k' then choice = 'spock'
    end

    if VALID_CHOICES.include?(choice)
      break
    else
      puts "That's not a valid choice, please pick again."
    end
  end

  computer_choice = VALID_CHOICES.sample

  unless check_for_tie(choice, computer_choice, stats)
    if win?(choice, computer_choice, 0)
      action = WINNING_MOVES[choice.to_sym][0][1]
      prompt("Your #{choice.upcase} #{action} the computer's " \
        "#{computer_choice.upcase}. You won!")
      stats[:wins] += 1
      stats[:total_rounds] += 1
      stats[:rounds] += 1
    elsif win?(choice, computer_choice, 1)
      action = WINNING_MOVES[choice.to_sym][1][1]
      prompt("Wow, you won! The #{choice.upcase} #{action} the computer's " \
        "#{computer_choice.upcase}. Amazing!")
      stats[:wins] += 1
      stats[:total_rounds] += 1
      stats[:rounds] += 1
    elsif win?(computer_choice, choice, 0)
      action = WINNING_MOVES[computer_choice.to_sym][0][1]
      prompt("You lost, the computer chose #{computer_choice.upcase} which " \
        "#{action} your #{choice.upcase}.")
      stats[:losses] += 1
      stats[:total_rounds] += 1
      stats[:computer_rounds] += 1
    elsif win?(computer_choice, choice, 1)
      action = WINNING_MOVES[computer_choice.to_sym][1][1]
      prompt("Sorry, the computer's #{computer_choice.upcase} totally " \
        "#{action} your #{choice.upcase}. You lost.")
      stats[:losses] += 1
      stats[:total_rounds] += 1
      stats[:computer_rounds] += 1
    end
  end

  check_for_match_win(stats)

  break unless play_again?
end

prompt("Thank you for playing! See you next time!")
prompt("============== <<")
