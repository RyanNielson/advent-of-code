require "set"

class Day25
  def part1(input)
    map = Map.new(input)

    i = 0
    loop do
      i += 1
      break i unless map.step
    end
  end

  def part2(input); end
end

Point = Struct.new(:x, :y)

class Map
  EAST = Point.new(1, 0)
  SOUTH = Point.new(0, 1)

  def initialize(input)
    @eastward, @southward, @max = parse(input)
  end

  def step
    @eastward, moved_east = move_cucumbers(@eastward, @eastward, @southward, EAST)
    @southward, moved_south = move_cucumbers(@southward, @eastward, @southward, SOUTH)
    moved_east || moved_south
  end

  def move_cucumbers(positions, eastward, southward, diff)
    new_positions = Set.new
    positions.each do |position|
      check_x = position.x + diff.x
      check_y = position.y + diff.y
      check_x = 0 if check_x > @max.x
      check_y = 0 if check_y > @max.y
      check = Point.new(check_x, check_y)

      if eastward.include?(check) || southward.include?(check)
        new_positions.add(position)
      else
        new_positions.add(check)
      end
    end

    [new_positions, new_positions != positions]
  end

  def parse(input)
    max_x = 0
    max_y = 0

    eastward = Set.new
    southward = Set.new

    input.split("\n").each_with_index do |row, y|
      max_y = y if y > max_y
      row.chars.each_with_index do |dir, x|
        max_x = x if x > max_x
        case dir
        when ">"
          eastward.add(Point.new(x, y))
        when "v"
          southward.add(Point.new(x, y))
        end
      end
    end

    [eastward, southward, Point.new(max_x, max_y)]
  end
end
