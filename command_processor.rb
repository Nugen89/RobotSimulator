class CommandProcessor

  attr_accessor :type, :user_input

  def initialize(input_type = "cmdline")
    @type = input_type
  end

  def get_input(&block)
    case @type
    when "cmdline"
      cmd_line_input(&block)
    else
      puts "Invalid input type. Program exiting."
    end
  end

  def prompt_input
    prompt = "> "
    print prompt
  end

  def cmd_line_input(&block)
    while true
      prompt_input
      user_input = gets.to_s.chomp
      yield user_input if block_given?
    end
  end


end