array1 = [1,2,3]
array2 = [4,5,6]
newarray = []

count = 0
finish = array1.size
p finish

loop do
  newarray << array1[count]
  newarray << array2[count]
  count += 1
  break if count == finish
end

p newarray