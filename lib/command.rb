# Represents command robot can execute
class Command
  PLACE  = 'place'.freeze
  MOVE   = 'move'.freeze
  LEFT   = 'left'.freeze
  RIGHT  = 'right'.freeze
  REPORT = 'report'.freeze

  # Available command names
  COMMANDS = [PLACE, MOVE, LEFT, RIGHT, REPORT].freeze

  # Error for invalid command name
  # It's raised when trying to initialize command with invalid name
  class InvalidCommand < StandardError; end

  # Return the name of the command
  #
  # @return [String] command name
  attr_reader :name

  # Return params associated with the command
  #
  # @return [Array] list of params
  attr_reader :params

  # Initialize a new instance of the command
  #
  # @param name [String] A valid command name
  # @param params [Array] An array of params
  #
  # @return [Command] a new instance of the command
  # @raise [Command::InvalidCommand] if the command name is invalid
  def initialize(name, params = nil)
    name = name.downcase
    raise InvalidCommand.new("'#{name}' is not a valid command") unless COMMANDS.include?(name)

    @name = name
    @params = params
  end
end
