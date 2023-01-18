puts "Hangman Game Initialized"

words = File.open('./root/word_dict.txt')
words = words.read.split(" ")
chosen_word = words.select {|word| (5..12).include? word.length }.sample
chances = chosen_word.length
chosen_word = chosen_word.split('')
guess_arr = Array.new(chosen_word.length)

def make_guess(guess_arr, chosen_word, char, x)
  chosen_word.each_with_index do |str, idx|

     guess_arr[idx] = char if str == char

    if chosen_word == guess_arr
      puts "You Won!!"
      break
    end
  end
  guess_arr
end
10.times do
  if chances == 0
    puts "YOU ARE HANGED!\nChosen word was #{chosen_word.join()}"
    break
  else
    puts "Guess the letters of the word.....\nChances left: #{chances}"
    x = gets.to_s.chomp
    p make_guess(guess_arr ,chosen_word, x, chances)
  end
  chances -= 1
end