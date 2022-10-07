def palindrome_substrings(str)
  result = []
  return result if str.nil? || str.empty?
  
  combos = []

  chunklength = 2
  while chunklength < str.length
      idx = 0
      while idx < str.length - (chunklength - 1)
        combos << str[idx,chunklength] 
        idx += 1
      end
    chunklength += 1
  end

  combos.each do |x|
    result << x if x == x.reverse
  end

  p combos
  result.sort
end

p palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
p palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
p palindrome_substrings("palindrome") == []
p palindrome_substrings("") == []
