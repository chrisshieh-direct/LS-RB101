require 'yaml'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
        [1, 4, 7], [2, 5, 8], [3, 6, 9],
        [1, 5, 9], [3, 5, 7]]
PLAYER_MARKER = 'X'
COMP_MARKER = 'O'
LANGUAGES = {
  'english' => {
    'get_who_first' => ['p', 'c', 'r']
  },
  'spanish' => {
    'get_who_first' => ['j', 'c', 'a']
  }
}

# methods
def localize(lang)
  if lang == "spanish"
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
  i = 1
  while i < 8
    divider_print
    row_print(brd, i)
    i += 3
  end
  divider_print
end

def who_goes_first(lang, text_src_local)
  input = get_who_first(lang, text_src_local)
  case input
  when 'p', 'j'
    'human'
  when 'c'
    'PC'
  when 'r', 'a'
    random_choice = rand(1..2)
    if random_choice == 1
      'human'
    else
      'PC'
    end
  end
end

def get_who_first(lang, text_src_local)
  prompt(text_src_local['who_first?'])
  input = ''
  loop do
    input = gets.chomp.downcase
    break if LANGUAGES[lang]['get_who_first'].include?(input)
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
  think
  choice = computer_ai(brd)
  brd[choice] = COMP_MARKER
  display_board(brd)
end

def think
  12.times do
    print '.'
    sleep rand / 3
  end
end

def computer_ai(brd)
  offense = ai_find_spot(brd, 2)
  return offense unless offense.nil?
  defense = ai_find_spot(brd, 1)
  return defense unless defense.nil?
  return 5 if empty_squares(brd).include?(5)
  empty_squares(brd).sample
end

def moves_track(brd, which)
  role = which == 1 ? PLAYER_MARKER : COMP_MARKER
  brd.select { |_k, v| v == role }.keys
end

def ai_find_spot(brd, which)
  moves = moves_track(brd, which)
  potential = WINNING_LINES.select do |arr|
    arr.select { |x| moves.include?(x) }.size == 2
  end
  if potential.size > 0
    potential.each do |arr|
      pot = arr.reject { |x| moves.include?(x) }.flatten.first
      return pot if brd[pot] == ' '
    end
  end
  nil
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
  which = role == 'human' ? PLAYER_MARKER : COMP_MARKER
  moves = brd.select { |_k, v| v == which }.keys
  WINNING_LINES.any? do |arr|
    arr.all? { |x| moves.include?(x) }
  end
end

def condition_check(brd, role)
  if victory?(brd, role)
    return role
  elsif board_full?(brd)
    return 'tie'
  end
  'continue'
end

def play_again?(text_src_local, lang)
  prompt(text_src_local['again'])
  answer = ''
  yes_check = lang == 'english' ? 'y' : 's'
  loop do
    answer = gets.chomp.downcase
    break if answer == yes_check || answer == 'n'
    prompt(text_src_local['not_valid_play_again'])
  end
  answer == yes_check
end

def display_result(result_local, text_src_local)
  case result_local
  when 'human'
    prompt(text_src_local['player_win'])
  when 'PC'
    prompt(text_src_local['comp_win'])
  when 'tie'
    prompt(text_src_local['tie'])
  end
end
# end methods

# game begins here
board = reset_board
player_wins = 0
computer_wins = 0
ties = 0

system 'clear'

prompt("Please choose a language: (E)nglish or (S)panish):")
language_select = ''
loop do
  language_select = gets.chomp.downcase
  break if language_select == 'e' || language_select == 's'
  prompt("Sorry, please choose 'E' for English, or 'S' for Spanish.")
end
language = language_select == 'e' ? 'english' : 'spanish'
text_src = localize(language)

# MAIN LOOP
loop do
  # draw the board
  board = reset_board
  display_board(board)
  first_move = who_goes_first(language, text_src)
  first_message = first_move == 'human' ? 'player_first' : 'computer_first'
  prompt(text_src[first_message])

  result = 'continue'

  loop do
    if first_move == 'human'
      player_move!(text_src, board)
      result = condition_check(board, 'human')
      break if result != 'continue'
      computer_move!(text_src, board)
      result = condition_check(board, 'PC')
    else
      computer_move!(text_src, board)
      result = condition_check(board, 'PC')
      break if result != 'continue'
      player_move!(text_src, board)
      result = condition_check(board, 'human')
    end
    break if result != 'continue'
  end

  display_result(result, text_src)

  case result
  when 'human'
    player_wins += 1
  when 'PC'
    computer_wins += 1
  when 'tie'
    ties += 1
  end

  if player_wins < 5 && computer_wins < 5
    if language == 'spanish'
      prompt("Has ganado #{player_wins} veces.")
      prompt("La computadora ha ganado #{computer_wins} veces.")
      prompt("Juegos de empate: #{ties}")
    else
      prompt("You've won #{player_wins} times.")
      prompt("The computer has won #{computer_wins} times.")
      prompt("Tie games: #{ties}")
    end

  elsif player_wins == 5
    prompt(text_src['player_victory'])
    player_wins = 0
    computer_wins = 0
  elsif computer_wins == 5
    prompt(text_src['computer_victory'])
    player_wins = 0
    computer_wins = 0
  end

  break unless play_again?(text_src, language)
end

prompt(text_src['thank_you'])
