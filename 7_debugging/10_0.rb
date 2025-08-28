=begin
Once I set DoesItRock::API_KEY to a wrong API key, the three outputs I got from
running the code were:
Sushi rocks!
Rain rocks!
Bug hunting rocks!

It seemed as though no error was raised and DoesItRock.find_out always returned
any keyword rocks no matter what the keyword argument was.
=end

=begin
I then used pry-byebug by putting a binding.pry inside SearchEngine::count to
investigate the problem. I found that when a wrong API_KEY is passed to
SearchEngine.count as the second argument, the AuthenticationError does get
raised by the unless clause in SearchEngine::count, but no error is output
because the error is rescued by the rescue clause in DoesItRock::Score. This
rescue clause then specifies NoScore to be returned, making NoScore the return
value of Score.for_term and it is assigned to score. Execution then moves on to
line 40, where score is the conditional keyword in a case statement. Next,
score, despite pointing to DoesItRock::NoScore, returns false after === is
called on it with NoScore as an argument, so the case statement does not move
on to its first conditional branch, but it moves on to the else branch,
ultimately returning "(keyword) rocks!".
=end

=begin
Lesson 3 of RB120 contains a lesson on Equivalence, which has a section on ===.
I reviewed the section and learned that === essentially asks: If the receiver
of === is a group, would the argument be in that group? This makes sense for
why, when I call DoesItRock::NoScore === DoesItRock::NoScore in a pry session,
it always returns false, even though they are the exactly same object.
=end

# My fix:
class AuthenticationError < Exception; end

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'WRONG KEY'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY)
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY)

      (positive * 100) / (positive + negative)
    rescue Exception
      NoScore
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)

    if score == NoScore
      "No idea about #{term}..."
    elsif (0...40).include?(score)
      "#{term} is not fun."
    elsif (40...60).include?(score)
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end

  rescue Exception => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!
