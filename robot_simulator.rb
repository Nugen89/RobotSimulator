require_relative 'command_processor'
require_relative 'robot'

class RobotSimulator

  attr_accessor :command_processor, :robot

  def initialize
    @command_processor = CommandProcessor.new
    @robot = Robot.new
  end

  def start

    @command_processor.get_input do |user_input|
      case user_input.split(' ')[0].downcase
      when "place"
        param = user_input.split(' ')[1]
        if placement_format(param)
          puts "Invalid placement. Re-enter with valid location."
        else
          puts "Placing Robot"
          puts @robot.place(param)
        end 
      when "move"
        puts "Moving Robot"
        @robot.move
        puts @robot.report_location
      when "left"
        puts "Rotating left"
        @robot.left
        puts @robot.report_location
      when "right"
        puts "Rotating right"
        @robot.right
        puts @robot.report_location
      when "report"
        puts "Robot's current location:"
        puts @robot.report_location
      when "exit"
        puts "Exiting program..."
        exit
      else
        puts "Command is not recognised. Please enter another command."
      end
    end

  end

  def placement_format(param)
    /\d,\d,[a-zA-Z]+/.match(param).nil?
  end

end