class Banner
  def initialize(message, width)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_lines, empty_line, horizontal_rule].join("\n")
  end

  private

  def empty_line
    len_limit = len_longest_framed_line - 4
    "| #{' ' * len_limit} |"
  end

  def horizontal_rule
    len_limit = len_longest_framed_line - 4
    "+-#{'-' * len_limit}-+"
  end

  def len_longest_framed_line
    message_lines.max_by { |framed_line| framed_line.length}.length
  end

  def message_lines
    framed_lines = []
    terms = @message.split
    current_line = []
    len_limit = @width - 4

    terms.each_with_index do |term, i|
      if (current_line.join(' ') + "#{term} ").length > (len_limit)
          str_current_line = current_line.join(' ')
          len_current_line = str_current_line.length
          framed_lines << "| #{str_current_line + (' ' * (len_limit - len_current_line))} |"
        current_line = [] << term
        if i == terms.length - 1
          str_current_line = current_line.join(' ')
          len_current_line = str_current_line.length
          framed_lines << "| #{str_current_line + (' ' * (len_limit - len_current_line))} |"
        end
      elsif i == terms.length - 1
        current_line << term
        str_current_line = current_line.join(' ')
        len_current_line = str_current_line.length
        framed_lines << "| #{str_current_line + (' ' * (len_limit - len_current_line))} |"
      else
        current_line << term
      end
    end

    framed_lines
  end
end

# Test cases:
# banner = Banner.new("To be or not to be", 10)
=begin
Expected output:
+--------+
| To be  |
| or not |
| to be  |
+--------+
=end

# banner = Banner.new("a aa aaa aaaaaa a", 10)
=begin
Expected output:
+--------+
| a aa   |
| aaa    |
| aaaaaa |
| a      |
+--------+
=end

=begin
- empty_line
  - Same framing but use the len of the longest line from arr returned by
    message_lines

- horizontal_line
  - Same framing but use the len of the longest line from arr returned by
    message_lines

- message_line needs to return an arr of framed individual lines instead
- Split input msg into lines with lengths that fit inside width appropriately
  - Break msg down into individual words and construct each line individually
    - Split input msg str into arr of strs at spaces
    - Iterate over arr of strs
      - Initialize an empty str current_line
      - Unless the len of current_line will be over (width - 4)
        - Append current str to current_line
      - Otherwise
        - Append current_line to message_lines with proper framing
        - Reset current_line to empty str
=end
