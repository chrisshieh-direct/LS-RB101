require 'yaml'

WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
        [1, 4, 7], [2, 5, 8], [3, 6, 9],
        [1, 5, 8], [3, 5, 7]]
PLAYER_MARKER = 'X'
COMP_MARKER = 'O'

# methods
def localize(lang)
  if lang == "2"
    YAML.load_file('tic_esp.yml')
  else
    YAML.load_file('tic.yml')
  end
end

def prompt(message)
  puts "==> #{message}"
end

def reset_board(brd)
  brd = { 1 => ' ', 2 => ' ', 3 => ' ',
          4 => ' ', 5 => ' ', 6 => ' ',
          7 => ' ', 8 => ' ', 9 => ' ' }
end

def divider_print
  puts '-------------'
end

def row_print(brd, s)
  puts '| ' + brd[s] + ' | ' + brd[s + 1] + ' | ' + brd[s + 2] + ' |'
end

def display_board(brd)
  system 'clear'
  divider_print
  row_print(brd, 1)
  divider_print
  row_print(brd, 4)
  divider_print
  row_print(brd, 7)
  divider_print
end

# game begins here
board = { 1 => ' ', 2 => ' ', 3 => ' ',
          4 => 'X', 5 => ' ', 6 => ' ',
          7 => ' ', 8 => ' ', 9 => ' ' }

prompt("Please choose a language ('1' for English, '2' for Spanish):")
language = gets.chomp
text_src = localize(language)

# main loop

# draw the board
display_board(board)
sleep 2
reset_board(board)
display_board(board)

# ask who goes first (choice or random)
# player 1 places
# check for win
# check for full
# player 2 places
# check for win
# check for full
# play again?
# thank you for playing
