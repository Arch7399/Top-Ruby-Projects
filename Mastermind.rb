class Mastermind
    attr_reader :code, :turns
    
    def initialize
      @code = []
      @turns = 0
    end
    
   
    def generate_code
      4.times { @code << rand(1..6) }
    end
    
   
    def play
      generate_code
      puts "Code has been generated. Time for the computer to guess!"
      loop do
        guess = []
        4.times { guess << rand(1..6) }
        @turns += 1
        result = check_guess(guess)
        if result == "++++"
          p result
          p self.code
          puts "Computer guessed the code in #{turns} turns!"
          break
        else
          puts "Guess: #{guess.join}"
          puts "Result: #{result}"
        end
      end
    end
    
    def check_guess(guess)
      result = ""
      guess.each_with_index do |num, index|
        if num == @code[index]
          result << "+"
        elsif @code.include?(num)
          result << "-"
        else
          result << " "
        end
      end
      result
    end
  end
  
  game = Mastermind.new
  game.play
  
  
  
  