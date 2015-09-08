require 'tokenizer'
require 'robot'

# Environment in which commands are executed
class Runner
  # Return list of the commands
  #
  # @return [Array] commands list
  attr_reader :commands

  # Return instance of the robot
  #
  # @return [Robot] robot
  attr_reader :robot

  # Initialize a new instance of the runner
  #
  # @param input [String] String with commands
  #
  # @return [Runner] a new instance of the runner
  def initialize(input)
    @commands = Tokenizer.tokenize(input)
    @robot = Robot.new
  end

  # Execute commands in correct order
  #
  # @return [Array] command list
  def run
    @commands.each do |command|
      case command.name
      when Command::PLACE
        @robot.place(*command.params)
      when Command::MOVE
        @robot.move
      when Command::LEFT
        @robot.left
      when Command::RIGHT
        @robot.right
      when Command::REPORT
        puts @robot.report
      end
    end
  end
end
