# Implement LSBot corrections/suggestions
require 'pry-byebug'

class GuessingGame
  NUMBER_GUESSES = 7
  LOWER_BOUND = 1
  UPPER_BOUND = 100

  def play
    reset
    loop do
      display_guesses_remaining
      self.player_guess = player_enter_a_number
      display_result
      self.num_guesses_remaining -= 1
      break if player_guess == target_number || num_guesses_remaining.zero?
    end
    display_final_result
  end

  private

  attr_accessor :num_guesses_remaining, :target_number, :player_guess

  def reset
    self.num_guesses_remaining = NUMBER_GUESSES
    self.target_number = (LOWER_BOUND..UPPER_BOUND).to_a.sample
  end

  def display_guesses_remaining
    if num_guesses_remaining == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{num_guesses_remaining} guesses remaining."
    end
  end

  def player_enter_a_number
    player_guess = nil
    loop do
      print "Enter a number between #{LOWER_BOUND} and #{UPPER_BOUND}: "
      player_guess = gets.to_i
      break if (LOWER_BOUND..UPPER_BOUND).include?(player_guess)

      print 'Invalid guess. '
    end
    player_guess
  end

  def display_result
    if player_guess > target_number
      puts 'Your guess is too high.'
    elsif player_guess < target_number
      puts 'Your guess is too low.'
    elsif player_guess == target_number
      puts "That's the number!"
    end
    puts
  end

  def display_final_result
    case player_guess
    when target_number then puts 'You won!'
    else puts 'You have no more guesses. You lost!'
    end
  end
end

game = GuessingGame.new
game.play

=begin
NOTES from LSBot
(Since) all of this logic is happening inside the class, you can also access
the instance variables directly using the @ prefix (e.g., @player_guess). This
is a very common and direct way to manage an object's internal state. Accessor
methods are most often used to create a public interface for other objects to
interact with an object's state. When the state is entirely internal, direct
access is often simpler.
=end
