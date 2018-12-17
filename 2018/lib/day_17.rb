class Day17
  def part1(input)
    ground = parse(input)

    ground.flow!(500, 0)

    ground.count_water
  end

  def part2(input)
    ground = parse(input)

    ground.flow!(500, 0)

    ground.count_resting_water
  end


  def parse(input)
    lines = input.split("\n")

    g = lines.reduce(Ground.new) do |ground, line|
      axis1, axis1_value, _, axis2_value_min, axis2_value_max = line.match(/(\w)=(\d+), (\w)=(\d+)..(\d+)/).captures

      (axis2_value_min.to_i..axis2_value_max.to_i).each do |i|
        if (axis1 == "x")
          ground.add_clay!(axis1_value.to_i, i)
        else
          ground.add_clay!(i, axis1_value.to_i)
        end
      end

      ground
    end

    g.recalculate_limits!

    g
  end
end

class Ground
  RESTING = "~"
  FLOWING = "|"
  CLAY    = "#"
  SAND    = "."

  def initialize
    @grid = Hash.new { |h, k| h[k] = SAND }
    @min_y = 0
    @max_y = 0
  end


  def flow!(x, y)
    add_flowing!(x, y)

    return if water?(x, y + 1)

    bottom = y
    bottom += 1 until bottom == @max_y || resting?(x, bottom)

    bottom.downto(y) do |i|
      add_flowing!(x, i)
    end

    bottom.downto(y) do |i|
      fill!(x, i) if resting?(x, i)
    end
  end

  def fill!(x, y)
    left, right = x, x
    left  -= 1 until clay?(left - 1, y)  || !resting?(left, y)
    right += 1 until clay?(right + 1, y) || !resting?(right, y)

    if resting?(left, y) && resting?(right, y)
      (left..right).each { |i| add_resting!(i, y) }
    else
      (left..right).each { |i| add_flowing!(i, y) }
    end

    flow!(left, y)  unless resting?(left, y)
    flow!(right, y) unless resting?(right, y)
  end

  def resting?(x, y)
    clay?(x, y + 1) || @grid[[x, y + 1]] == RESTING
  end

  def add_clay!(x, y)
    @grid[[x, y]] = CLAY
  end

  def add_resting!(x, y)
    @grid[[x, y]] = RESTING
  end

  def add_flowing!(x, y)
    @grid[[x, y]] = FLOWING
  end

  def water?(x, y)
    [RESTING, FLOWING].include?(@grid[[x, y]])
  end

  def clay?(x, y)
    @grid[[x, y]] == CLAY
  end

  def recalculate_limits!
    @min_y, @max_y = minmax_y
  end

  def minmax_y
    @grid.keys.map(&:last).minmax
  end

  def minmax_x
    @grid.keys.map(&:first).minmax
  end

  def count_water
    @grid.count { |(_, y), v| y >= @min_y && y <= @max_y && (v == FLOWING || v == RESTING) }
  end

  def count_resting_water
    @grid.count { |(_, y), v| y >= @min_y && y <= @max_y && v == RESTING }
  end

  def display
    min_x, max_x = minmax_x
    min_y, max_y = minmax_y

    (min_y..max_y).to_a.each do |y|
      puts (min_x..max_x).to_a.map{ |x| @grid[[x, y]]}.join
    end

    puts ""
  end
end