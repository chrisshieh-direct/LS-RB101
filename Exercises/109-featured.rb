def featured(int)
  int.odd? && int % 7 == 0 && int.digits.uniq.length == int.digits.length
end

p featured(7)
p featured(12)
p featured(21)
p featured(997)
p featured(1029)
p featured(999_999)
p featured(101)