def substrings(s)
  0.upto(s.length - 1).flat_map do |start| 
    1.upto(s.length - start).map do |length| 
      s[start, length]
    end
  end.uniq
end