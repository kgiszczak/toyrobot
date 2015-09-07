class Command
  PLACE  = 'place'.freeze
  MOVE   = 'move'.freeze
  LEFT   = 'left'.freeze
  RIGHT  = 'right'.freeze
  REPORT = 'report'.freeze

  COMMANDS = [PLACE, MOVE, LEFT, RIGHT, REPORT].freeze

  class InvalidCommand < StandardError; end

  attr_reader :name, :params

  def initialize(name, params = nil)
    name = name.downcase
    raise InvalidCommand.new("'#{name}' is not a valid command") unless COMMANDS.include?(name)

    @name = name
    @params = params
  end
end
