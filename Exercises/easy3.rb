def multisum(x)
  sum = 0
  for y in 1..x
    sum += y if y % 3 == 0 || y % 5 == 0
  end
  sum
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168