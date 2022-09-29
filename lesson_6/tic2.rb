def display_board(a)
  system('clear')
  puts '-------------'
  puts '| ' + cell(a[0]) + ' | ' + cell(a[1]) + ' | ' + cell(a[2]) + ' |'
  puts '-------------'
  puts '| ' + cell(a[3]) + ' | ' + cell(a[4]) + ' | ' + cell(a[5]) + ' |'
  puts '-------------'
  puts '| ' + cell(a[6]) + ' | ' + cell(a[7]) + ' | ' + cell(a[8]) + ' |'
  puts '-------------'
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

def change_board(c,b,p)
  if p == 1
    b[c] = 1
  elsif p == 2
    b[c] = 2
  end
end

board = [0,0,0,0,0,0,0,0,0]

display_board(board)

loop do
  choice = 0

  loop do
    puts "Pick a square, 1-9."
    choice = gets.to_i-1
    if board[choice] != 0
      puts "Sorry, that's occupied. Pick again."
      next
    else
      break
    end
  end

  change_board(choice, board, 1)

  display_board(board)
  #check_winner
  #check_for_tie

  puts "Now the computer will pick a square."
  sleep 2
  computer = 0

  loop do
    computer = rand(0..8)
    if board[computer] != 0
      next
    else
      break
    end
  end

  change_board(computer, board, 2)

  display_board(board)
  #check_winner
  #check_for_tie

end
