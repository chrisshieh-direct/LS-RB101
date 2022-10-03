puts "Chris and Steven are playing."
sleep 1
puts "Who will call the flip?"

def flip
  [1,2].sample
end

5.times do
  print " . "
  sleep 0.25
end

who_goes = flip

if who_goes == 1
  player = "Chris"
  puts "Chris will call the flip."
else
  player = "Steven"
  puts "Steven will call the flip."
end

sleep 1

what_called = flip

if flip == 1
  call = "heads"
  puts "#{player} calls #{call}."
else
  call = "tails"
  puts "#{player} calls #{call}."
end

print "Flipping ."
4.times do
  print " ."
  sleep 0.25
end

res = flip

if flip == 1
  puts "The coin lands on HEADS."
  result = 'heads'
else
  puts "the coin lands on TAILS."
  result = 'tails'
end

if call == result
  puts "#{player} wins!"
else
  puts "#{player} loses."
end
