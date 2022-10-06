WINS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

board = [0,0,0,0,0,0,0,0,0]

def space(index,state)
  if state[index] == 0
    ' '
  elsif state[index] == 1
    'X'
  elsif state[index] == 2
    'O'
  end
end

def display_board(curr)
  system('clear')
  puts 'TIC TAC TOE!!'
  puts '-------------'
  puts '| ' + space(0,curr) + ' | ' + space(1,curr) + ' | ' + space(2,curr) + ' |'
  puts '-------------'
  puts '| ' + space(3,curr) + ' | ' + space(4,curr) + ' | ' + space(5,curr) + ' |'
  puts '-------------'
  puts '| ' + space(6,curr) + ' | ' + space(7,curr) + ' | ' + space(8,curr) + ' |'
  puts '-------------'
end

def check_for_win(arr)
  tempx = []
  tempy = []

  arr.each_with_index do |e,index|
    if e == 1
      tempx << index
    elsif e == 2
      tempy << index
    end
  end

  WINS.each do |sub|
    if sub.all? { |e| tempx.include?(e) }
      return "Player wins!"
    elsif sub.all? { |e| tempx.include?(e) }
      return "Computer wins!"
    else
      return "No winner."
    end
  end

end

loop do
  display_board(board)
  choice = nil

  loop do
    puts "Pick a square from 1 to 9 to mark with an X!"
    choice = gets.to_i
    choice -= 1
    if board[choice] != 0
      puts "Sorry, that spot is taken, pick another."
      next
    end
    break
  end

  board[choice] = 1
  display_board(board)
  p board
  puts "Now the computer will pick a space to mark with an O."
  sleep 1
  computer = 0

  loop do
    computer = [0,1,2,3,4,5,6,7,8].sample
    break if board[computer] == 0
  end

  board[computer] = 2
  display_board(board)
  sleep 1

  puts check_for_win(board)
end
