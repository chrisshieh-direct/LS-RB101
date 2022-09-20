advice = "Few things in life are as important as house training your pet dinosaur."
advice = advice.gsub!("important","urgent")
puts advice

numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1)
p numbers
numbers = [1, 2, 3, 4, 5]
numbers.delete(1)
p numbers

t = Time.now
puts (10..100).include?(42)
puts Time.now - t

t = Time.now
puts (10..100).cover?(42)
puts Time.now - t

famous_words = "seven years ago..."
puts "Four score and #{famous_words}"

famous_words = "Four score and " + famous_words
puts famous_words

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flintstones.flatten!

p flintstones

flintstones_hash = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

barney_array = [flintstones_hash.key(2),flintstones_hash["Barney"]]

p barney_array