require 'prime'

def gap(g, m, n)
  possibles = Prime.each(n).select { |x| x >= m }
  possibles.each_cons(2) do |a, b|
    if (a - b).abs == g
      return [a, b]
    end
  end
  nil
end

p gap(2, 100, 110) == [101, 103]
p gap(4,100,110) == [103, 107]
p gap(6,100,110) == nil
p gap(8,300,400) == [359, 367]
p gap(10,300,400) == [337, 347]