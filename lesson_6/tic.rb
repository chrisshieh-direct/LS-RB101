require 'yaml'

WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
        [1, 4, 7], [2, 5, 8], [3, 6, 9],
        [1, 5, 9], [3, 5, 7]]
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

def reset_board
  { 1 => ' ', 2 => ' ', 3 => ' ',
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

def who_goes_first(lang, text_src_local)
  input = get_who_first(lang, text_src_local)
  case input
  when 'p', 'j'
    1
  when 'c'
    2
  when 'r', 'a'
    random_choice = rand(1..2)
    if random_choice == 1
      1
    else
      2
    end
  end
end

def get_who_first(lang, text_src_local)
  prompt(text_src_local['who_first?'])
  input = ''
  loop do
    input = gets.chomp.downcase
    if lang == '2'
      break if ['j', 'c', 'a'].include?(input)
    elsif ['p', 'c', 'r'].include?(input)
      break
    end
    prompt(text_src_local['invalid_who_first?'])
  end
  input
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == ' ' }
end

def player_move!(text_src_local, brd)
  move = 0

  loop do
    prompt(text_src_local['get_move'] + " (#{joinor(empty_squares(brd))})")
    move = gets.to_i
    if empty_squares(brd).include?(move)
      break
    else
      prompt(text_src_local['invalid_move'])
    end
  end

  brd[move] = PLAYER_MARKER

  display_board(brd)
end

def computer_move!(text_src_local, brd)
  random_comp_line = "computer_will_move_" + rand(1..15).to_s
  prompt(text_src_local[random_comp_line])
  sleep 1.75
  brd[empty_squares(brd).sample] = COMP_MARKER
  display_board(brd)
end

def joinor(arr, delimiter = ', ', connector = 'or')
  return arr.first if arr.size == 1
  oxford = if arr.size > 2
             delimiter
           else
             ' '
           end
  *most, last = arr
  most.join(delimiter) + "#{oxford}#{connector} #{last}"
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def victory?(brd, role)
  which = role == 1 ? PLAYER_MARKER : COMP_MARKER
  moves = brd.select { |_k, v| v == which }.keys
  WINS.any? do |arr|
    arr.all? { |x| moves.include?(x) }
  end
end

def condition_check(brd, role)
  if victory?(brd, role)
    return role
  elsif board_full?(brd)
    return 3
  end
  return 0
end
# end methods

# game begins here
board = reset_board

prompt("Please choose a language ('1' for English, '2' for Spanish):")
language = gets.chomp
text_src = localize(language)

# MAIN LOOP

# draw the board
display_board(board)
first = who_goes_first(language, text_src)
if first == 1
  prompt(text_src['player_first'])
else
  prompt(text_src['computer_first'])
end

result = 0

loop do
  if first == 1
    player_move!(text_src, board)
    result = condition_check(board, 1)
    break if result != 0
    computer_move!(text_src, board)
    result = condition_check(board, 2)
    break if result != 0
  else
    computer_move!(text_src, board)
    result = condition_check(board, 2)
    break if result != 0
    player_move!(text_src, board)
    result = condition_check(board, 1)
    break if result != 0
  end
end

case result
when 1
  prompt(text_src['player_win'])
when 2
  prompt(text_src['comp_win'])
when 3
  prompt(text_src['tie'])
end
# play again?
# thank you for playing
