#!/usr/bin/env ruby

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
    p @secret
    @secret
  end

  def hide_secret
    @hide = @secret.chars.map { '_' }
    puts @hide.join(' ')
  end

  def guess_word
    begin
      print "Enter a single character: "
      @guess = gets.chomp.downcase
    end until @guess.length == 1

    @guess
  end

  def reveal_char
    @secret.chars.each_with_index do |char, idx|
      @hide[idx] = char if char == @guess
    end
    puts @hide.join(' ')
  end

  def game_rounds
    rounds = 5

    while rounds > 0
      guess_word

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
  end
end

play = Hangman.new
play.secret_word
play.hide_secret
play.game_rounds

