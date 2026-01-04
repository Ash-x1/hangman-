#!/usr/bin/env ruby
class Hangman
  attr_reader :secret, :guess, :hide

  def initalize
    @secret
    @guess
    @hide
  end

  def secret_word
    file = File.readlines('hangman_words.txt').map(&:chomp)
    @secret = file.select { |word| 5 <= word.length && word.length <= 12 }.sample.downcase
    p @secret
    @secret
  end

  def hide_secret
    @hide = @secret.chars.map do |i|
      '_'
    end
    p @hide
    @hide
  end

  def guess_word
    @guess = ""
    until @guess.length == 1 do 
      p 'Please insert your guess (tip: you should type only 1 character)'
      @guess = gets.chomp.downcase
      p @guess 
    end
    @guess
  end
  
  def check_answer
    if @secret.include?(@guess)
      p 'That is great'
    else 
      p 'That is wrong'
    end
  end

  def reveal_char
    guess  = @guess
    secret = @secret.chars
    hide   = @hide
    secret.each_with_index do |char, idx|
      if guess == char 
        p "the index is: #{idx}"
      end
    end
  end

  def game_result(guess, secret)
    if guess == secret
      p 'Congratulations'
    else
      p 'At least u tried'
    end
  end
end

play = Hangman.new
secret = play.secret_word
play.hide_secret
guess = play.guess_word
play.check_answer
play.reveal_char
play.game_result(guess, secret)
