class Robot

  DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"]
  MAX_DIST = 4

  attr_accessor :coordinates, :direction

  def initialize
    @coordinates = NullCoordinates.new
  end

  def place(command)
    coord, direction = command.split(',').each_slice(2).to_a
    coord = coord.map { |e| e.to_i }
    direction = direction.join.upcase

    if validate_coordinates(coord) && validate_direction(direction)
      @coordinates = coord 
      @direction = direction
      "Robot placed at #{report_location}"
    else
      "Invalid robot placement"
    end
  end

  def validate_placement    
    raise NullCoordinatesException.new("Robot has not been placed.") if coordinates.class == NullCoordinates
  end

  def validate_coordinates(coord)
    coord.select {|i| !(0..4).include?(i) }.empty?
  end

  def validate_direction(direction)
    DIRECTIONS.include?(direction)
  end

  def move
    validate_placement

    case @direction
    when "NORTH"
      @coordinates[1] += 1 if @coordinates[1] < MAX_DIST
    when "SOUTH"
      @coordinates[1] -= 1 if @coordinates[1] > 0
    when "EAST"
      @coordinates[0] += 1 if @coordinates[0] < MAX_DIST
    when "WEST"
      @coordinates[0] -= 1 if @coordinates[0] > 0
    end
    self
  end

  def left
    validate_placement
    @direction = DIRECTIONS[DIRECTIONS.index(@direction) - 1]
    self
  end

  def right
    validate_placement
    if  @direction == DIRECTIONS[-1]
      @direction = DIRECTIONS.first
    else
      @direction = DIRECTIONS[DIRECTIONS.index(@direction) + 1] 
    end
    self
  end

  def report_location
    validate_placement
    "#{coordinates.join(",")} | #{direction}"
  end

end


class NullCoordinates 
end

class NullCoordinatesException < StandardError
  def initialize(data)
    @data = data
  end
end
