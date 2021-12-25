class Day25
  def part1(input)
    map = Map.new(input)
    # map.step

    loop do
      break map.step_count unless map.step
    end
    # p map
  end

  def part2(input)
    # split_input = input.split.map(&:to_i)
  end
end

Point = Struct.new(:x, :y)

# TODO: Separate eastward and southward cucumbers instead of lumping them up.
class Map
  attr_accessor :step_count, :cucumbers, :min, :max

  def initialize(input)
    @cucumbers, @min, @max = parse(input)
    @step_count = 0
  end

  def step
    moved = false
    eastward = @cucumbers.filter { |_key, value| value == ">" }.to_h
    southward = @cucumbers.filter { |_key, value| value == "v" }.to_h

    new_eastward = {}
    eastward.each do |position, value|
      check_x = position.x + 1
      check_x = 0 if check_x > @max.x
      check = Point.new(check_x, position.y)

      if eastward.key?(check) || southward.key?(check)
        new_eastward[position] = value
      else
        new_eastward[check] = value
        moved = true
      end
    end

    new_southward = {}
    southward.each do |position, value|
      check_y = position.y + 1
      check_y = 0 if check_y > @max.y
      check = Point.new(position.x, check_y)

      if southward.key?(check) || new_eastward.key?(check)
        new_southward[position] = value
      else
        new_southward[check] = value
        moved = true
      end
    end

    @cucumbers = new_eastward.merge(new_southward)
    @step_count += 1
    moved
  end

  def parse(input)
    max_x = 0
    max_y = 0

    cucumbers = input.split("\n").each_with_index.each_with_object({}) do |(row, y), acc|
      max_y = y if y > max_y
      row.chars.each_with_index do |dir, x|
        max_x = x if x > max_x
        acc[Point.new(x, y)] = dir if dir != "."
      end
    end

    [cucumbers, Point.new(0, 0), Point.new(max_x, max_y)]
  end

  def bounds
    min_x, max_x = @@cucumbers.keys.minmax_by(&:x)
    min_y, max_y = @@cucumbers.keys.minmax_by(&:y)
    [Point.new(min_x, min_y), Point.new(max_x, max_y)]
  end
end
