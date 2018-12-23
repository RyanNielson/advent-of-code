class Day23
  def part1(input)
    nanobots = parse(input)

    strongest = nanobots.max_by { |n| n.r }

    nanobots.select{ |n| strongest.in_range?(n) }.count
  end

  def parse(input)
    lines = input.split("\n").map(&:strip)

    lines.map do |line|
      x, y, z, r = line.scan(/pos=<(-?\d+),(-?\d+),(-?\d+)>, r=(-?\d+)/).flatten.map(&:to_i)

      Nanobot.new(x, y, z, r)
    end
  end
end

class Nanobot
  attr_reader :x, :y, :z, :r

  def initialize(x, y, z, r)
    @x = x
    @y = y
    @z = z
    @r = r
  end

  def in_range?(other)
    (x - other.x).abs + (y - other.y).abs + (z - other.z).abs <= r
  end
end