#!/usr/bin/env ruby
# require 'yaml'
class Hangman
  attr_reader :secret, :guess

  def initalize(secret, guess)
    @secret = secret
    @guess  = guess
  end

  def pick_word
    file = File.readlines('hangman_words.txt').map(&:chomp)
    word = file.select { |word| 5 <= word.length && word.length <= 12 }.sample
    p word
  end
end

play = Hangman.new
play.pick_word
