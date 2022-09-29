WINS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

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

def change_board(c,b,p,rec)
  if p == 1
    b[c] = 1
    rec << c
  elsif p == 2
    b[c] = 2
    rec << c
  end
end

def check_winner(board,rec,player)
  if WINS.any?{ |y| y.all?{ |x|rec.include?(x)} }
    if player == 1
      puts "You WIN!"
    else
      puts "The computer wins."
    end
    true
  end
end

board = [0,0,0,0,0,0,0,0,0]
record = []
comp_record = []

#MAIN LOOP
loop do
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

    change_board(choice, board, 1, record)

    display_board(board)

    break if check_winner(board,record,1)
    #check_for_tie

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

    break if check_winner(board,comp_record,2)
    #check_for_tie
  end

  puts "Play again?"
  again = gets.chomp.downcase
  if again == "y"
    board = [0,0,0,0,0,0,0,0,0]
    record = []
    comp_record = []
    next
  else
    puts "Thank you for playing!"
    break
  end
end
