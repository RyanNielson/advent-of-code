require "set"
require "pqueue"

class Day15
  def part1(input)
    grid = Grid.new(input)
    start = Position.new(0, 0)
    paths = dijkstra(grid, start)
    shortest_path(grid, start, paths).sum { |position| grid[position] }
  end

  def part2(input)
    grid = Grid.new(duplicated_input(input))
    start = Position.new(0, 0)
    paths = dijkstra(grid, start)
    shortest_path(grid, start, paths).sum { |position| grid[position] }
  end

  # Thanks Wikipedia!
  def dijkstra(grid, start)
    dist = grid.positions.each_with_object({ start => 0 }) do |position, d|
      d[position] = Float::INFINITY if position != start
    end
    prev = {}
    q = grid.positions.to_set
    queue = PQueue.new
    queue.push([0, start])

    until q.empty?
      min = queue.shift.last
      q.delete(min)

      grid.neighbours(min).each do |neighbour|
        alt = dist[min] + grid[neighbour]

        next unless alt < dist[neighbour]

        dist[neighbour] = alt
        prev[neighbour] = min
        queue.push([alt, neighbour])
      end
    end

    prev
  end

  def shortest_path(grid, start, paths)
    current_position = grid.max_position
    path = []
    while current_position != start
      path << current_position
      current_position = paths[current_position]
    end

    path
  end

  def duplicated_input(input)
    vertical_sections = []
    5.times do |y|
      rows = []
      5.times do |x|
        rows << input.split("\n").map do |i|
          i.split("").map(&:to_i).map { |n| n + x + y }.map { |n| n > 9 ? n % 9 : n }.map(&:to_s)
        end
      end

      vertical_sections << rows
                           .transpose
                           .map { |line| line.map(&:join) }
                           .map { |line| line.join }
                           .join("\n")
    end

    vertical_sections.join("\n")
  end
end

Position = Struct.new(:x, :y)

class Grid
  def initialize(input)
    @grid = input.split("\n").each_with_index.each_with_object({}) do |(row, y), grid|
      row.chars.each_with_index do |value, x|
        grid[Position.new(x, y)] = value.to_i
      end
    end
  end

  def neighbours(position)
    [
      Position.new(position.x + 1, position.y),
      Position.new(position.x - 1, position.y),
      Position.new(position.x, position.y + 1),
      Position.new(position.x, position.y - 1)
    ].reject { |point| @grid[point].nil? }
  end

  def positions
    @grid.keys
  end

  def value(position)
    @grid[position]
  end

  def [](position)
    @grid[position]
  end

  def max_position
    Position.new(positions.max_by(&:x).x, positions.max_by(&:y).y)
  end
end
