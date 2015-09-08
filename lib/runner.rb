require 'tokenizer'
require 'robot'

class Runner
  attr_reader :commands, :robot

  def initialize(input)
    @commands = Tokenizer.tokenize(input)
    @robot = Robot.new
  end

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
