class Day11
  COORDINATES = (1..300).to_a.product((1..300).to_a)

  def part1(input)
    serial_number = parse(input)

    grid = build_grid(3)
    power_level_grid =

    power_levels = grid.reduce(Hash.new) do |h, (key, value)|
      h[key] = value.sum { |coordinate| power_level(coordinate, serial_number) }
      h
    end

    power_levels.max_by{ |k, v| v }.first.join(",")
  end

  # WE ALREADY HAVE PREVIOUS SUMS, SO WE CAN USE THAT PLUS NEW THAT WAY WE ONLY CALCULATE POWER LEVEL ONCE FOR EACH GRID
  def part2(input)
    serial_number = parse(input)

    (1..300).to_a.reduce(Hash.new) do |h, square_size|
      puts square_size

      before = Time.now
      grid = build_grid(square_size)
      puts "TIME OF BUILD GRID: #{Time.now - before}"

      before = Time.now
      power_levels = grid.reduce(Hash.new) do |h, (key, value)|
        h[key] = value.sum { |coordinate| power_level(coordinate, serial_number) }
        h
      end
      # puts square_size
      puts "TIME OF POWER LEVEL: #{Time.now - before}"

      h[square_size] = power_levels.max_by{ |k, v| v }

      # puts square_size
      puts h[square_size].inspect

      h
    end
  end

  def power_level(coordinate, serial_number)
    x, y = coordinate

    rack_id = x + 10
    power_level = rack_id * y
    power_level += serial_number
    power_level *= rack_id
    power_level = power_level / 100 % 10
    power_level - 5
  end

  # TODO: We can probably shrink the size substantially when you get near the edge of the grid.
  def build_grid(square_size)
    offset_range = (0...square_size).to_a;
    offsets = offset_range.product(offset_range)

    COORDINATES.reduce(Hash.new) do |grid, coordinate|
      grid[coordinate] = build_square(coordinate, offsets)
      grid
    end
  end

  def power_level_grid
    offset_range = (0...square_size).to_a;
    offsets = offset_range.product(offset_range)

    COORDINATES.reduce(Hash.new) do |grid, coordinate|
      grid[coordinate] = build_square(coordinate, offsets)
      grid
    end
  end

  def build_square(coordinate, offsets)
    x, y = coordinate

    offsets.map { |(offset_x, offset_y)| [x + offset_x, y + offset_y] }
  end

  def parse(input)
    input.strip.to_i
  end
end
