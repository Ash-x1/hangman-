#!/usr/bin/env ruby

require_relative 'lib/logic'

game = Hangman.new

if SaveGame.exist?
  puts "Saved game found:"
  puts "1 - Continue"
  puts "2 - New game"
  puts "3 - Delete save"

  choice = gets.chomp

  case choice
  when "1"
    data = SaveGame.load
    game.instance_variable_set(:@secret, data["secret"])
    game.instance_variable_set(:@hide, data["hide"])
    puts game.hide.join(' ')
    game.game_rounds(data["rounds"])
  when "2"
    SaveGame.delete
    game.secret_word
    game.hide_secret
    game.game_rounds
  when "3"
    SaveGame.delete
    puts "Save deleted."
  else
    puts "Invalid choice."
  end
else
  game.secret_word
  game.hide_secret
  game.game_rounds
end

