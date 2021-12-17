require "set"

class Day17
  def part1(input)
    highest_y, = handle_moves(input)
    highest_y
  end

  def part2(input)
    _, velocities = handle_moves(input)
    velocities.count
  end

  def handle_moves(input)
    target_area, min, max = parse_target_area(input)
    highest_y = 0
    velocities = []

    # There's probably a better or more correct way to limit the velocity window... but this works.
    (0..max.x).each do |x|
      (min.y..max.x).each do |y|
        velocity = Position.new(x, y)
        success, possible_highest_y = move(Position.new(0, 0), target_area, min, velocity)

        if success
          highest_y = possible_highest_y if possible_highest_y > highest_y
          velocities << velocity
        end
      end
    end

    [highest_y, velocities]
  end

  def move(probe, target_area, min, velocity)
    highest_y = probe.y
    success = false

    while !success && probe.y >= min.y
      probe.x += velocity.x
      probe.y += velocity.y
      if velocity.x.positive?
        velocity.x -= 1
      elsif velocity.x.negative?
        velocity.x += 1
      end
      velocity.y -= 1

      highest_y = probe.y if probe.y > highest_y
      success = target_area.include?(probe)
    end

    [success, highest_y]
  end

  def parse_target_area(input)
    x_input, y_input = input.match(/x=(.+), y=(.+)/)[1, 2]
    x_range = eval(x_input)
    y_range = eval(y_input)
    target_area = x_range.map do |x|
      y_range.map { |y| Position.new(x, y) }
    end

    [target_area.flatten.to_set, Position.new(x_range.min, y_range.min), Position.new(x_range.max, y_range.max)]
  end
end

Position = Struct.new(:x, :y)
