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

Position = Struct.new(:x, :y)

class OctopusGrid
  def initialize(input)
    @grid = input.split("\n").each_with_index.each_with_object({}) do |(row, y), grid|
      row.chars.each_with_index do |energy, x|
        grid[Position.new(x, y)] = energy.to_i
      end
    end
  end

  def step
    increase_energy
    flash
  end

  def increase_energy
    @grid.each do |position, energy|
      @grid[position] = energy + 1
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
          @grid[n] += 1
          positions << n if @grid[n] > 9
        end
    end

    flashed.each { |position| @grid[position] = 0 }
    flashed
  end

  def positions_to_flash
    @grid
      .map do |(position, energy)|
        position if energy > 9
      end
      .compact
  end

  def neighbour_positions(position)
    neighbours = [
      Position.new(position.x + 1, position.y),
      Position.new(position.x - 1, position.y),
      Position.new(position.x, position.y + 1),
      Position.new(position.x, position.y - 1),
      Position.new(position.x + 1, position.y + 1),
      Position.new(position.x + 1, position.y - 1),
      Position.new(position.x - 1, position.y + 1),
      Position.new(position.x - 1, position.y - 1)
    ]

    neighbours.reject { |point| @grid[point].nil? }
  end

  def count
    @grid.length
  end
end
