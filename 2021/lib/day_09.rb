class Heightmap
  def initialize(input)
    @grid = input.split("\n").map do |line|
      line.chars.map(&:to_i)
    end
  end

  def height(x, y)
    return nil if x.negative? || y.negative? || y >= @grid.length || x >= @grid[0].length

    @grid[y][x]
  end

  def neighbours(x, y)
    [
      height(x + 1, y),
      height(x - 1, y),
      height(x, y + 1),
      height(x, y - 1)
    ].compact
  end

  def low_points
    @grid
      .each_with_index.map do |row, y|
        row.each_with_index.map do |height, x|
          neighbours = neighbours(x, y)

          height if neighbours.all? { |neighbour| height < neighbour }
        end
      end
      .flatten
      .compact
  end
end

class Day09
  def part1(input)
    heightmap = Heightmap.new(input)
    heightmap.low_points.sum { _1 + 1 }
  end

  # def part2(input)
  #   split_input = input.split.map(&:to_i)
  # end
end
