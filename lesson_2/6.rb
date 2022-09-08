puts "Give me a number, please."
num1 = gets.to_i

puts "What's the second number?"
num2 = gets.to_i

options = ["a","s","m","d"]
op = nil

loop do
puts "Would you like to add, subtract, multiply, or divide? (A/S/M/D)"
op = gets.chomp.downcase
  if options.include?(op)
    break
  else
    puts "That's not one of the choices. Please type A, M, S, or D."
  end
end

case op
  when "a"
    result = num1 + num2
  when "s"
    result = num1 - num2
  when "m"
    result = num1 * num2
  else
    result = num1.to_f / num2.to_f
end

puts result