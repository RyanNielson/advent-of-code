class Day06
  def part1(input)
    coords = prep_input(input)
    grid = build_grid(coords)

    closest_points = grid.reduce(Hash.new { |h, k| h[k] = Hash.new(0) }) do |distances, cell|
      dists = coords.reduce(Hash.new) do |memo, coord|
        memo[coord] = manhattan_distance(coord, cell)
        memo
      end

      sorted_distances = dists.sort_by { |location, distance| distance }.first(2)

      distances[cell] = sorted_distances.first[1] == sorted_distances.last[1] ? nil : sorted_distances.first[0]

      distances
    end

    cleaned_counts = closest_points.reduce(Hash.new(0)) do |counts, (cell, coord)|
      counts[coord] = nil if infinite?(cell, coords)
      counts[coord] += 1 if coord && !counts[coord].nil?

      counts
    end

    cleaned_counts
      .delete_if { |coord, value| value.nil? || infinite?(coord, coords) }
      .values
      .max
  end

  def part2(input, distance)
    coords = prep_input(input)
    grid = build_grid(coords)

    grid.reduce([]) do |result, cell|
      result << cell if coords.reduce(0) { |sum, coord| sum + manhattan_distance(coord, cell) } < distance
      result
    end.count
  end

  def build_grid(coords)
    bb_x_1, bb_y_1, bb_x_2, bb_y_2 = bounding_box(coords)
    x_range = (bb_x_1...bb_x_2).to_a
    y_range = (bb_y_1...bb_y_2).to_a

    x_range.product(y_range)
  end

  def infinite?(coord, coords)
    x, y = coord
    bb_x_1, bb_y_1, bb_x_2, bb_y_2 = bounding_box(coords)

    x <= bb_x_1 || x >= bb_x_2 || y <= bb_y_1 || y >= bb_y_2
  end

  def bounding_box(coords)
    min_x, _ = coords.min_by { |coord| coord[0] }
    max_x, _ = coords.max_by { |coord| coord[0] }
    _, min_y = coords.min_by { |coord| coord[1] }
    _, max_y = coords.max_by { |coord| coord[1] }

    [min_x, min_y, max_x, max_y]
  end

  def manhattan_distance(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
  end

  def prep_input(input)
    input.split("\n").map(&:strip).map { |coords| coords.split(", ").map(&:to_i) }
  end
end
