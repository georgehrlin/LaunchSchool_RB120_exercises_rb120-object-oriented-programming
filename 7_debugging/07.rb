=begin
Without looking at any of the two provided hints and after using pry-byebug to
investigate, I discovered that the cause of the bug is on line 21. success is
assigned to -30 instead of false. (self.balance -= 30) returns -30 instead of
false. false is the intended value to be assigned to success. This leads to
line 27 being executed since -30 is always evaluated to true.

I find it baffling that (self.balance -= amount) on line 21 returns -30
because, in my debugging, execution of line 21 does invoke the custom balance=
with an argument of -30. This means that (self.balance -= amount), which is
Ruby syntactic sugar for (self.balance = self.balance - amount) should return
false, but instead it returns -30.
=end

=begin
After looking at Hint #1, I'm thinking: Is the reason (self.balance -= amount)
returns -30 because Ruby always returns the value that a variable is assigned
to after executing an assignment operation?

Here, (self.balance -= amount) is syntactic sugar for
(self.balance = self.balance - amount). self.balance - amount is evluated to
-30, so BankAccount#balance= is then invoked with -30 as an argument.
BankAccount#balance= indeed returns false, but (I am guessting here) because of
the inclusion of =, Ruby still treats this as an assignment operation somehow
and returns the value to be assigned, which is -30.
=end

=begin
After some back-and-forth with "LSBot for Help", I learned that Ruby always
evaluates the entirety of the expression to the right of the = and then returns
it, no matter if that evaluated value is assigned to anything or not.
=end

class BankAccount
  attr_accessor :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0
      if (self.balance - amount) >= 0
        self.balance -= amount
        success = true
      else
        success = false
      end
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

=begin
NOTES
A setter method ALWAYS returns the value that was passed in as an argument,
even if return is used within the method body to specify an alternative return
value. The argument is always returned.
=end
