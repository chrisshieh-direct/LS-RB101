def display_board(h)
  puts '-------------'
  puts '| ' + cell(h[:tl]) + ' | ' + cell(h[:tm]) + ' | ' + cell(h[:tr]) + ' |'
  puts '-------------'
  puts '| ' + cell(h[:ml]) + ' | ' + cell(h[:mm]) + ' | ' + cell(h[:ml]) + ' |'
  puts '-------------'
  puts '| ' + cell(h[:bl]) + ' | ' + cell(h[:bm]) + ' | ' + cell(h[:bl]) + ' |'
  puts '-------------'
end

def cell(value)
  value.to_s
end

board = {tl:0,tm:0,tr:0,ml:0,mm:0,mr:0,bl:0,bm:0,br:0}

display_board(board)