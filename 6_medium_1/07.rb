class GuessingGame
  def initialize(lower_bound, upper_bound)
    @range = lower_bound..upper_bound
  end

  def play
    reset
    current_guess = nil
    loop do
      display_guesses_remaining
      current_guess = player_enter_a_number
      display_result(current_guess)
      @num_guesses_remaining -= 1
      break if current_guess == @target_number || @num_guesses_remaining.zero?
    end
    display_final_result(current_guess)
  end

  private

  def reset
    @num_guesses_remaining = Math.log2(@range.size).to_i + 1
    @target_number = rand(@range)
  end

  def display_guesses_remaining
    if @num_guesses_remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{@num_guesses_remaining} guesses remaining."
    end
  end

  def player_enter_a_number
    player_guess = nil
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      player_guess = gets.to_i
      break if (@range).cover?(player_guess)

      print 'Invalid guess. '
    end
    player_guess
  end

  def display_result(player_guess)
    if player_guess > @target_number
      puts 'Your guess is too high.'
    elsif player_guess < @target_number
      puts 'Your guess is too low.'
    elsif player_guess == @target_number
      puts "That's the number!"
    end
    puts
  end

  def display_final_result(player_guess)
    case player_guess
    when @target_number then puts 'You won!'
    else puts 'You have no more guesses. You lost!'
    end
  end
end

game = GuessingGame.new(501, 1500)
game.play
