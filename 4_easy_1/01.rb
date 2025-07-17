class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line,
     message_line, empty_line,
     horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{ '-' * (message_line.length - 2) }+" # @message.length is better here
  end

  def empty_line
    "|#{ ' ' * (message_line.length - 2) }|" # @message.length is better here
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end
