require_relative 'save'

class Hangman
  attr_reader :secret, :guess, :hide

  def initialize
    @secret = nil
    @guess  = nil
    @hide   = []
  end

  def secret_word
    file = File.readlines('hangman_words.txt').map(&:chomp)
    @secret = file.select { |word| word.length.between?(5, 12) }.sample.downcase
  end

  def hide_secret
    @hide = @secret.chars.map { '_' }
    puts @hide.join(' ')
  end

  def guess_word
    begin
      print "Enter a single character or type 'save': "
      @guess = gets.chomp.downcase
    end until @guess.length == 1 || @guess == "save"

    @guess
  end

  def reveal_char
    @secret.chars.each_with_index do |char, idx|
      @hide[idx] = char if char == @guess
    end
    puts @hide.join(' ')
  end

  def game_rounds(rounds = 4)
    while rounds > 0
      guess_word

      if @guess == "save"
        SaveGame.save(@secret, @hide, rounds)
        puts "Game saved."
        return
      end

      if @secret.include?(@guess)
        puts "Correct guess!"
        reveal_char
      else
        rounds -= 1
        puts "Wrong guess! Remaining attempts: #{rounds}"
      end

      break if @hide.join == @secret
    end

    if @hide.join == @secret
      puts "Congratulations! You won. The word was: #{@secret}"
    else
      puts "Game over! The word was: #{@secret}"
    end

    SaveGame.delete
  end
end

