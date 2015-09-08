# Class representing the robot
class Robot
  NORTH = 'north'.freeze
  EAST  = 'east'.freeze
  SOUTH = 'south'.freeze
  WEST  = 'west'.freeze

  # Available directions
  DIRECTIONS = [NORTH, EAST, SOUTH, WEST].freeze

  # Max size of the table in x direction
  POSITION_X_MAX = 4

  # Max size of the table in y direction
  POSITION_Y_MAX = 4

  class RobotError < StandardError; end

  # Error for incorect direction
  # It's raised when trying to set direction with incorrect name
  class IncorrectDirection < RobotError; end

  # Error for incorect position
  # It's raised when trying to move place robot on incorrect position
  class IncorrectPosition < RobotError; end

  # Return the x position of the robot
  #
  # @return [Fixnum] x position
  attr_reader :x

  # Return the y position of the robot
  #
  # @return [Fixnum] y position
  attr_reader :y

  # Return the direction
  #
  # @return [Fixnum] direction
  attr_reader :direction

  # Set position x, position y and direction
  #
  # @param x [Fixnum] x position
  # @param y [Fixnum] y position
  # @param direction [String] direction
  def place(x, y, direction)
    @placed = false

    self.x = x
    self.y = y
    self.direction = direction

    @placed = true
  end

  # Return wheter the robot is placed correctly on the table
  #
  # @return [Bool] is the robot placed correctly
  def placed?
    @placed == true
  end

  # Change direction of the robot to the left
  def left
    return unless placed?
    self.direction = DIRECTIONS[direction_index - 1]
  end

  # Change direction of the robot to the right
  def right
    return unless placed?
    self.direction = DIRECTIONS[(direction_index + 1) % 4]
  end

  # Change robot position
  #
  # @raise [Robot::IncorrectPosition] if the movement can't be done
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

  # Return report about robot state
  #
  # @return [String] A report about robot state
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
