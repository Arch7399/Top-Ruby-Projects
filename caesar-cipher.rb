def caesar_cipher(text, shift)
  shifted = []
  text.split("").each do |char|
    if (char.is_a? String) && (char =~ /[a-zA-Z]/)
        if char =~ /[a-z]/
        char = ((char.ord - "a".ord + shift) % 26 + "a".ord).chr
        shifted << char
        elsif char =~ /[A-Z]/
        char = ((char.ord - "A".ord + shift) % 26 + "A".ord).chr
        shifted << char
        end
    else 
      shifted << char
    end
  end
  shifted.join()
end
puts caesar_cipher("Aa bB cC dG?", 20)
