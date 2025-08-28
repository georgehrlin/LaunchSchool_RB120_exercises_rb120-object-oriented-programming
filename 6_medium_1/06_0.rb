module Displayable
  def display_guesses_remaining
    puts "You have #{@num_guesses_remaining} guesses remaining."
  end

  def display_player_prompt
    print "Enter a number netween #{GuessingGame::NUMBER_LOWER_BOUND} " \
         "and #{GuessingGame::NUMBER_UPPER_BOUND}: "
  end

  def display_invalid_guess
    print 'Invalid guess. '
  end
end

class GuessingGame
  include Displayable

  NUMBER_GUESSES = 7
  NUMBER_LOWER_BOUND = 1
  NUMBER_UPPER_BOUND = 100

  def initialize
    @num_guesses_remaining = NUMBER_GUESSES
    @target_number = (NUMBER_LOWER_BOUND..NUMBER_UPPER_BOUND).to_a.sample
    @player_guess
  end

  def play
    loop do
      display_guesses_remaining
      player_enter_a_number
      display_result
      @num_guesses_remaining -= 1
      break if @player_guess == @target_number || @num_guesses_remaining.zero?
    end
    display_final_result
  end

  def player_enter_a_number
    player_guess = nil
    loop do
      display_player_prompt
      player_guess = gets.to_i
      break if (NUMBER_LOWER_BOUND..NUMBER_UPPER_BOUND).include?(player_guess)
      display_invalid_guess
    end
    @player_guess = player_guess
  end

  def display_result
    if @player_guess > @target_number
      puts "Your guess is too high."
    elsif @player_guess < @target_number
      puts "Your guess is too low."
    elsif @player_guess == @target_number
      puts "That's the number!"
    end
    puts
  end

  def display_final_result
    case @player_guess
    when @target_number then puts 'You won!'
    else
      puts 'You have no more guesses. You lost!'
    end
  end
end
