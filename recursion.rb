#Individual Recursion methods

def facto(n)
    if n == 1
      return 1
    else
      return n + facto(n-1)
    end
  end
  puts facto(3)
  
  #palindrome
  def palindrome(str)
    len = str.length
    if len == 0 || len == 1
      true
    elsif str.chars.first == str.chars.last
      str.slice!(0)
      str.slice!(-1)
      palindrome(str)
    else
      false
    end
  end
  puts palindrome('madame')
  
  #bottles
  def bottler(num)
    if num == 1
      puts "#{num} bottles left"
    else
      puts "#{num} bottles left"
      bottler(num-1)
    end
  end
  bottler(13)
  
  #fibonacci
  def fibonacci(n)
    if n <= 0
      return 0
    elsif n == 1
      return 1
    else
      return fibonacci(n-1) + fibonacci(n-2)
    end
  end
  puts fibonacci(3) 
  
  #flattener
  def flatten(array, result = [])
    array.each do |element|
      if element.kind_of?(Array)
        flatten(element, result)
      else
        result << element
      end
    end
    result
  end
  
  #int_to_roman
  def int_to_roman(num, roman_mapping)
    return "" if num == 0
    roman_mapping.keys.each do |divisor|
      quotient, modulus = num.divmod(divisor)
      return roman_mapping[divisor] * quotient + int_to_roman(modulus, roman_mapping) if quotient > 0
    end
  end
  
  roman_mapping = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }
  puts int_to_roman(1999, roman_mapping) # "MCMXCIX"
  
  #roman_to_int
  def roman_to_int(str, roman_mapping)
    return 0 if str.empty?
    roman_mapping.keys.each do |key|
      if str.start_with?(key)
        return roman_mapping[key] + roman_to_int(str[key.length..-1], roman_mapping)
      end
    end
  end
  
  roman_mapping = {
    "M" => 1000,
    "CM" => 900,
    "D" => 500,
    "CD" => 400,
    "C" => 100,
    "XC" => 90,
    "L" => 50,
    "XL" => 40,
    "X" => 10,
    "IX" => 9,
    "V" => 5,
    "IV" => 4,
    "I" => 1}
  
    puts roman_to_int("MCMXCIX", roman_mapping)