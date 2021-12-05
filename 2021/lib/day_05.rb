class Day05
  def part1(input)
    line_segments(input)
      .filter(&:horizontal_or_vertical?)
      .then { point_count(_1) }
  end

  def part2(input)
    line_segments(input)
      .then { point_count(_1) }
  end

  def point_count(line_segments)
    line_segments
      .map(&:points)
      .flatten(1)
      .tally
      .values
      .count { |c| c > 1 }
  end

  def line_segments(input)
    input
      .split
      .each_slice(3)
      .map { |coord1, _, coord2| LineSegment.new(coord(coord1), coord(coord2)) }
  end

  def coord(str)
    str.split(",").map(&:to_i)
  end
end

class LineSegment
  def initialize(coord1, coord2)
    @x1, @y1 = coord1
    @x2, @y2 = coord2
  end

  def horizontal_or_vertical?
    @y1 == @y2 || @x1 == @x2
  end

  def step(point1, point2)
    amount = 1 if point1 > point2
    amount = -1 if point1 < point2
    amount = 0 if point1 == point2
    amount
  end

  def points
    point_enum = Enumerator.new do |y|
      x_step = step(@x2, @x1)
      y_step = step(@y2, @y1)
      point = [@x1, @y1]
      loop do
        y << point
        point = [point[0] + x_step, point[1] + y_step]
      end
    end

    point_enum
      .take_while { _1 != [@x2, @y2] }
      .push([@x2, @y2])
  end
end
