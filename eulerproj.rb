=begin
#Sum of naturals, problem 1
def naturalnum_sum(num, sum = 0)
    return sum if num == 0
    if num % 3 == 0 || num % 5 == 0
      sum += num
    end
    naturalnum_sum(num - 1, sum)
  end
  
puts naturalnum_sum(10)

#even fibonacci sum, problem 2
def even_fibonacci_sum(num, sum = 0, a = 1, b = 2)
  if b > num
    sum
  else
    sum += b if b.even?
    even_fibonacci_sum(num, sum, b, a + b)
  end
end
puts even_fibonacci_sum(40)
=end

#largest prime factor, problem 3
def largest_prime_factor(num, i=2)
  return i if num == i
  return largest_prime_factor(num/i, i) if num % i == 0
  largest_prime_factor(num, i+1)
end

puts largest_prime_factor(1001)

#largest 3 digit palindrome product
def largest_palindrome
  largest, a, b = 0
  (100..999).each do |i|
    (100..999).each do |j|
      prod = i * j
      if prod.to_s == prod.to_s.reverse && prod > largest
          largest = prod 
          a = i
          b = j
      end
    end
  end
  "#{largest} was largest and prods were #{a} and #{b}"
end

puts largest_palindrome
