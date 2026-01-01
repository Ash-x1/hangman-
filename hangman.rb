#!/usr/bin/env ruby
# require 'yaml'
class Hangman
  attr_reader :secret, :guess

  def initalize
    @secret
    @guess
  end

  def pick_word
    file = File.readlines('hangman_words.txt').map(&:chomp)
    @secret = file.select { |word| 5 <= word.length && word.length <= 12 }.sample
    p @secret
  end

  def hide_secret
    hide = @secret.chars.map do |i|
      @secret.replace('_')
    end
    p hide
  end
end

play = Hangman.new
play.pick_word
play.hide_secret
