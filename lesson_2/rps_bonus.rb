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
=end

VALID_CHOICES = %w[rock, paper, scissors, lizard, spock]
def prompt(str)
  puts ">> #{str}"
end

prompt('Welcome to RPSLS!')

prompt('Make your choice: (R)ock, (P)aper, (S)cissors, (L)izard, or Spoc(k)!')
choice = gets.chomp.downcase
case choice
when 'r' then choice = 'rock'
when 'p' then choice = 'paper'
when 's' then choice = 'scissors'
when 'l' then choice = 'lizard'
when 'k' then choice = 'spock'
end

if VALID_CHOICES.include?(choice)
  then puts "That's valid."
else
  puts "That's not valid."
end

computer_choice = VALID_CHOICES.sample

p computer_choice
p choice
