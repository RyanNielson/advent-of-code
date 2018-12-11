class Day11
  COORDINATES = (1..300).to_a.product((1..300).to_a)

  def part1(input)
    serial_number = parse(input)

    max_power_level(serial_number, 3).first.join(",")
  end

  def part2(input)
    serial_number = parse(input)

    best = (1..16).to_a.reduce(Hash.new) do |b, square_size|
      b[square_size] = max_power_level(serial_number, square_size)
      b
    end

    (bsize, ((bx, by), _)) = best.max_by{ |size, ((x, y), value) | value }
    "#{bx},#{by},#{bsize}"
  end

  def max_power_level(serial_number, size)
    grid = build_grid(size)

    power_levels = grid.reduce(Hash.new) do |levels, (key, value)|
      levels[key] = value.sum { |coordinate| power_level(coordinate, serial_number) }
      levels
    end

    power_levels.max_by{ |k, v| v }
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

  def build_grid(square_size)
    offset_range = (0...square_size).to_a;
    offsets = offset_range.product(offset_range)

    coords_range = (1..(300 - square_size + 1)).to_a
    coordinates = coords_range.to_a.product(coords_range)

    coordinates.reduce(Hash.new) do |grid, coordinate|
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
