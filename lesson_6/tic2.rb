WINS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
  [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
]

def display_board(a)
  system('clear')
  line
  row(a, 0, 1, 2)
  line
  row(a, 3, 4, 5)
  line
  row(a, 6, 7, 8)
  line
end

def line
  puts '-------------'
end

def row(a2, x, y, z)
  puts '| ' + cell(a2[x]) + ' | ' + cell(a2[y]) + ' | ' + cell(a2[z]) + ' |'
end

def cell(value)
  if value == 0
    ' '
  elsif value == 1
    'X'
  else
    'O'
  end
end

def change_board(c, b, p, rec)
  if p == 1
    b[c] = 1
    rec << c
  elsif p == 2
    b[c] = 2
    rec << c
  end
end

def check_winner(rec, player)
  if WINS.any? { |y| y.all? { |x| rec.include?(x) } }
    if player == 1
      puts "You WIN!"
    else
      puts "The computer wins."
    end
    true
  end
end

def check_tie(board)
  if board.include?(0)
    return false
  else
    puts "It's a TIE!"
  end
  true
end

board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
record = []
comp_record = []

# MAIN LOOP
loop do
  display_board(board)

  loop do
    choice = 0

    loop do
      puts "Pick a square, 1-9."
      choice = gets.to_i - 1
      if board[choice] != 0
        puts "Sorry, that's occupied. Pick again."
        next
      else
        break
      end
    end

    change_board(choice, board, 1, record)

    display_board(board)

    break if check_winner(record, 1)
    break if check_tie(board)

    puts "Now the computer will pick a square."
    sleep 1
    computer = 0

    loop do
      computer = rand(0..8)
      if board[computer] != 0
        next
      else
        break
      end
    end

    change_board(computer, board, 2, comp_record)

    display_board(board)

    break if check_winner(comp_record, 2)
    break if check_tie(board)
  end

  puts "Play again?"
  again = gets.chomp.downcase
  if again == "y"
    board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    record = []
    comp_record = []
    next
  else
    puts "Thank you for playing!"
    break
  end
end
