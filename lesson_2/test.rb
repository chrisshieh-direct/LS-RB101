stats= {
  total_rounds: 0,
  wins: 0,
  losses: 0,
  ties: 1,
}
p stats

x = 5

def test(a,array)
if a > 3
  array[:ties] += 1
end
end

test(x,stats)
puts test(x,stats)
p stats
