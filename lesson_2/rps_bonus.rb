=begin
RPS Bonus -- create a rock paper scissors-style game with extra features

INPUTS
* Player chooses rock, paper, scissors, lizard, or Spock
* Player chooses whether to play another round

OUTPUTS
* Display result of the game (who won)
* Display running total of wins-losses (and percentage)
* Display grand champion every time player or computer reaches three wins

DATA
* Player choice
* Computer choice (random sample)
* Player total rounds
* Player wins
* Player losses
* Tie rounds
* Player win percentage (wins / total rounds)
* Grand champion wins for player and computer

LOGIC
* How to determine winner (and note if there is a tie)
If choices equal, it's a tie.
If player chooses ROCK (Computer: Lizard or Scissors (W), Spock or Paper (L))
If player chooses LIZARD (Computer: Spock or Paper (W), Scissors (L))
If player chooses SPOCK (Computer: Scissors (W), Paper (L))
If player chooses SCISSORS (Computer: Paper (W))
(Can we just calculate W and "else" the losses?)

METHODS
* Prompt
* Display result (determine winner)
* Calculate win-loss with percentage
* Calculate grand champion (with match history)

TALK IT OUT
1. Clear window, welcome, get player choice.
2. Randomly pick computer choice.
3. Are they the same? Then it's a tie (add 1 to the tie count)
4. Combine the choices into a combo. Check for winning combos.
   (If it's a win, add 1 to the win count)
5. Print the winning message.
6. If it's not a tie or win, it's a loss (add 1 to the loss count)
7. Is this a total of 3 wins for player or computer? Then it's a
   match win (add 1 to match win)
8. Give the stats: "You've played X matches won Y times for a winning
   percentage of Z. You've also tied L times. So far you've won M matches and
   the computer has won N. Would you like to play another round?"
=end

VALID_CHOICES = %w[rock paper scissors lizard spock]
WINNING_COMBOS = %w[rocklizard rockscissors lizardspock lizardpaper spockrock
                    spockscissors scissorslizard scissorspaper paperrock
                    paperspock]
total_rounds = 0
wins = 0
losses = 0
ties = 0
rounds = 0
win_pct = 0
computer_rounds = 0
match_win_count = 0
computer_match_win_count = 0

def prompt(str)
  puts ">> #{str}"
end

def endround
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
  yesno
end

loop do
  system('clear')
  prompt('Welcome to RPSLS!')
  if total_rounds > 0
    prompt("You've played #{total_rounds} times, winning #{wins} rounds, losing #{losses} rounds, and you tied #{ties} times.")
    win_pct = (wins.to_f / total_rounds.to_f) * 100
    prompt("Your winning percentage is #{win_pct.round(2)}%")
    prompt("You've won #{match_win_count} matches and the computer has won #{computer_match_win_count}.")
  end

  choice = ''

  loop do
    prompt('Make your choice: (R)ock, (P)aper, (S)cissors, (L)izard, or Spoc(K)!')
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
  combo = choice + computer_choice

  if choice == computer_choice
    prompt("You both chose #{choice.upcase}! You tied!")
    ties += 1
    total_rounds += 1
  elsif WINNING_COMBOS.include?(combo)
    prompt("Your #{choice.upcase} defeated the computer's #{computer_choice.upcase}. You won!")
    wins += 1
    total_rounds += 1
    rounds += 1
  else
    prompt("The computer chose #{computer_choice.upcase}, which beat your #{choice.upcase}. You lost.")
    losses += 1
    total_rounds += 1
    computer_rounds += 1
  end

  if rounds == 3
    prompt("============== <<")
    prompt("You won this match, #{rounds}-#{computer_rounds}!")
    rounds = 0
    computer_rounds = 0
    match_win_count += 1
  elsif computer_rounds == 3
    prompt("============== <<")
    prompt("Aw, the computer won this match, #{computer_rounds}-#{rounds}.")
    rounds = 0
    computer_rounds = 0
    computer_match_win_count += 1
  end

  again = endround

  if again == "y" || again == "yes"
    next
  else
    prompt("Thank you for playing! See you next time!")
    prompt("============== <<")
    break
  end
end
