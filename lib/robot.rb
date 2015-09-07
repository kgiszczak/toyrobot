class Robot
  DIRECTIONS = %w(north east south west)

  POSITION_X_MAX = 4
  POSITION_Y_MAX = 4

  class RobotError < StandardError; end
  class IncorrectDirection < RobotError; end
  class IncorrectPosition < RobotError; end

  attr_reader :x, :y, :direction

  def initialize(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
  end

  def left
    self.direction = DIRECTIONS[direction_index - 1]
  end

  def right
    self.direction = DIRECTIONS[(direction_index + 1) % 4]
  end

  def move
    case direction
    when 'north'
      self.x += 1
    when 'east'
      self.y += 1
    when 'south'
      self.x -= 1
    when 'west'
      self.y -= 1
    end
  rescue IncorrectPosition
    puts "I can't move there!"
  end

  def report
    "#{x}, #{y}, #{direction}"
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