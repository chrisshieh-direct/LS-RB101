require 'pry'
system("clear")
=begin
PROBLEM: Calculate mortgage payment

EXAMPLES:
  TEST $117999 / 3 years / 2% APR = $3379.80 monthly payment
  TEST $50000 / 5 years / 8% APR = $1013.82
  TEST $430000 / 30 years / 5% APR = $2308.33

DATA:
  INPUT >> Loan amount (2 digit float)
  INPUT >> APR
  INPUT >> Loan duration

ALGO: m = p * (j / (1 - (1 + j)**(-n)))
=end

def prompt(message)
  puts "---> #{message}"
end

loop do
  loan_amount = ''
  loop do
    prompt "What is the loan amount?"
    loan_amount = gets.chomp
    if loan_amount.empty? || loan_amount.to_f < 0
      prompt "Must enter a positive number."
      next
    else
      loan_amount = loan_amount.to_f
      break
    end
  end

  apr = ''
  monthly_apr = ''
  loop do
    prompt "What is the APR?"
    apr = gets.chomp
    if apr.empty? || apr.to_f < 0
      prompt "Must enter a positive number"
      next
    else
      apr = apr.to_f / 100
      monthly_apr = apr / 12
      break
    end
  end

  years = ''
  months = ''
  loop do
    prompt "How many years long is the loan?"
    years = gets.chomp
    if years.empty? || years.to_i < 0
      prompt "Must enter a valid number of years."
      next
    else
      months = years.to_i * 12
      break
    end
  end

  prompt "Calculating..."
  payment = if monthly_apr == 0
              loan_amount.to_f / months.to_f
            else
              loan_amount * (monthly_apr / (1 - (1 + monthly_apr)**(-months)))
            end
  prompt "Your monthly payment will be $#{format('%.2f', payment)}."

  prompt "Would you like to calculate again? Y/N"
  again = gets.chomp
  if again == "Y" || again == "y"
    next
  else
    prompt "Thanks for using the calculator!"
    break
  end
end
