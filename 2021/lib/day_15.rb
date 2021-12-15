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
    queue = PQueue.new
    queue.push([0, start])

    until queue.empty?
      min = queue.shift.last

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
    5.times.map do |y|
      5.times.map do |x|
        input.split("\n").map do |i|
          i.chars.map { _1.to_i + x + y }.map { _1 > 9 ? _1 % 9 : _1 }.map(&:to_s)
        end
      end
       .transpose.map { _1.map(&:join) }.map(&:join).join("\n")
    end
     .join("\n")
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
