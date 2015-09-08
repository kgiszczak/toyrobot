class Robot
  NORTH = 'north'.freeze
  EAST  = 'east'.freeze
  SOUTH = 'south'.freeze
  WEST  = 'west'.freeze

  DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

  POSITION_X_MAX = 4
  POSITION_Y_MAX = 4

  class RobotError < StandardError; end
  class IncorrectDirection < RobotError; end
  class IncorrectPosition < RobotError; end

  attr_reader :x, :y, :direction

  def place(x, y, direction)
    @placed = false

    self.x = x
    self.y = y
    self.direction = direction

    @placed = true
  end

  def placed?
    @placed == true
  end

  def left
    return unless placed?
    self.direction = DIRECTIONS[direction_index - 1]
  end

  def right
    return unless placed?
    self.direction = DIRECTIONS[(direction_index + 1) % 4]
  end

  def move
    return unless placed?

    case direction
    when NORTH
      self.y += 1
    when EAST
      self.x += 1
    when SOUTH
      self.y -= 1
    when WEST
      self.x -= 1
    end
  rescue IncorrectPosition
    puts "I can't move there!"
  end

  def report
    if placed?
      "#{x}, #{y}, #{direction}"
    else
      "Robot hasn't been placed yet on the table"
    end
  end

  private

  def x=(val)
    val = val.to_i

    if val < 0 || val > POSITION_X_MAX
      raise IncorrectPosition.new("Position x of value '#{val}' is not allowed")
    end

    @x = val
  end

  def y=(val)
    val = val.to_i

    if val < 0 || val > POSITION_Y_MAX
      raise IncorrectPosition.new("Position y of value '#{val}' is not allowed")
    end

    @y = val
  end

  def direction=(val)
    val = val.downcase

    unless DIRECTIONS.include?(val)
      raise IncorrectDirection.new("'#{val}' direction is incorrect. Try using #{DIRECTIONS.join(', ')}")
    end

    @direction = val
  end

  def direction_index
    DIRECTIONS.index(self.direction)
  end
end
