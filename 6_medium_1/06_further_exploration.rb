=begin
FURTHER EXPLORATION
Q: We took a straightforward approach here and implemented a single class. Do
you think it's a good idea to have a Player class?
A: A Player class is not necessary for the current requirement of the game
since there is only one player. It'd be a good idea to have a Player class when
there are multiple players. It would allow for better manageament of different
states that belong to several players.

Q: What methods and data should be part of it?
A: Instances of a Player class would perform behaviours that involving playing
the game, so the class would have at least a "guess" method. The states of the
instances would be keeping track of player-related stats like a "score" for
determining a winner among multiple players.

Q: How many Player objects do you need?
A: At least one, and as many as a round of the game requires.

Q: Should you use inheritance, a mix-in module, or a collaborative object?
A: A Player instance is not conceptually a sub-form of the GuessingGame class,
so inheritance can be ruled out. Mix-in module can also be ruled out because it
cannot create instances but we need instances of Player. Therefore, a
collaborative object is the only option.
=end
