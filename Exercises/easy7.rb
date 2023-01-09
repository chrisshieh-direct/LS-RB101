words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
  'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
  'flow', 'neon']

sorted = words.map do |word|
  word.chars.sort.join
end

anagrams = {}

sorted.uniq.each do |sortword|
  anagrams[sortword] = []
end

words.each do |word|
  key = word.chars.sort.join
  anagrams[key] << word
end

anagrams.each do |k, v|
  puts "Letters in '#{k}' anagram to: #{v.sort}"
end
