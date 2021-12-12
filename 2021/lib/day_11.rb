class Day11
  def part1(input)
    octopi = OctopusGrid.new(input)

    (0...100).sum do |_|
      octopi.step.count
    end
  end

  def part2(input)
    octopi = OctopusGrid.new(input)

    1.step do |i|
      break i if octopi.step.count == octopi.count
    end
  end
end

# TODO: Using a hash with point struct would be cleaner.
class OctopusGrid
  def initialize(input)
    @grid = input.split("\n").map do |line|
      line.chars.map(&:to_i)
    end
  end

  def step
    increase_energy
    flash
  end

  def increase_energy
    @grid
      .each_with_index do |row, y|
        row.each_with_index do |_, x|
          @grid[y][x] += 1
        end
      end
  end

  def flash
    flashed = []
    positions = positions_to_flash

    until positions.empty?
      position = positions.pop
      next if flashed.include?(position)

      flashed << position
      neighbours = neighbour_positions(position)
      neighbours
        .each do |n|
          @grid[n[1]][n[0]] += 1
          positions << n if @grid[n[1]][n[0]] > 9
        end
    end

    flashed.each { |x, y| @grid[y][x] = 0 }
    flashed
  end

  def positions_to_flash
    to_flash = []
    @grid
      .each_with_index do |row, y|
      row.each_with_index do |energy, x|
        to_flash << [x, y] if energy > 9
      end
    end

    to_flash
  end

  def neighbour_positions(position)
    x, y = position
    neighbours = [
      [x + 1, y],
      [x - 1, y],
      [x, y + 1],
      [x, y - 1],
      [x + 1, y + 1],
      [x + 1, y - 1],
      [x - 1, y + 1],
      [x - 1, y - 1]
    ]

    neighbours.reject do |x, y|
      x.negative? || y.negative? || y >= @grid.length || x >= @grid[0].length
    end
  end

  def count
    @grid.length * @grid[0].length
  end
end
