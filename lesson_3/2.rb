ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.include?("Spot")

p ages.key?("Spot")

p ages.member?("Spot")

munsters_description = "The Munsters are creepy in a good way."

puts munsters_description.swapcase!
puts munsters_description.capitalize!
puts munsters_description.downcase!
puts munsters_description.upcase!

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

additional_ages = { "Marilyn" => 22, "Spot" => 237 }

ages.merge!(additional_ages)

p ages

advice = "Few things in life are as important as house training your pet dinosaur."

if advice =~ /Dino/
  puts "Yes it does."
else
  puts "No it doesn't."  
end

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

secondflintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

puts flintstones == secondflintstones

flintstones << "Dino"

p flintstones

flintstones.pop

p flintstones

flintstones.push("Dino", "Hoppy")

p flintstones

advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!(0..38)
p advice

statement = "The Flintstones Rock!"
puts statement.count('t')

system('clear')
title = "Flintstone Family Members"
puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
padding = (40 - title.length) / 2
padding.times {print " "}
puts title
puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

puts title.center(40, '-')