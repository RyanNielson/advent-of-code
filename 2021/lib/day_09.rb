require "set"

class Day09
  def part1(input)
    Heightmap.new(input).low_points.sum { _1 + 1 }
  end

  def part2(input)
    Heightmap.new(input)
             .basins
             .sort { |basin1, basin2| basin1.length <=> basin2.length }
             .slice(-3..-1)
             .reduce(1) { |acc, basin| acc * basin.length }
  end
end

class Heightmap
  def initialize(input)
    @grid = input.split("\n").map do |line|
      line.chars.map(&:to_i)
    end
  end

  def height(position)
    x, y = position
    return nil if x.negative? || y.negative? || y >= @grid.length || x >= @grid[0].length

    @grid[y][x]
  end

  def neighbours(position)
    x, y = position
    [
      height([x + 1, y]),
      height([x - 1, y]),
      height([x, y + 1]),
      height([x, y - 1])
    ].compact
  end

  def neighbour_positions(position)
    x, y = position
    [
      [x + 1, y],
      [x - 1, y],
      [x, y + 1],
      [x, y - 1]
    ]
  end

  def low_points
    low_point_positions.map { height(_1) }
  end

  def low_point_positions
    @grid
      .each_with_index.map do |row, y|
        row.each_with_index.map do |height, x|
          [x, y] if neighbours([x, y]).all? { |neighbour| height < neighbour }
        end
      end
      .flatten(1)
      .compact
  end

  def basins
    low_point_positions.map do |low_position|
      visited_positions = Set.new
      check_positions = [low_position]

      loop do
        break visited_positions if check_positions.empty?

        check_position = check_positions.pop
        visited_positions.add(check_position)

        valid_neighbour_positions = neighbour_positions(check_position).reject do |position|
          neighbour_height = height(position)
          neighbour_height.nil? || visited_positions.member?(position) || neighbour_height >= 9 || neighbour_height <= height(check_position)
        end

        check_positions.concat(valid_neighbour_positions)
      end
    end
  end
end
