class Day18
  def part1(input)
    grid = simulate(parse(input), 10)
    resource_value(grid)
  end

  def part2(input)
    grid = simulate(parse(input), 1000000000)
    resource_value(grid)
  end

  def simulate(grid, minutes)
    previous = [grid]

    minutes.times do |i|
      grid = transform(grid)

      if previous.include?(grid)
        start = previous.index(grid)
        grid_loop = previous[start..-1]

        return grid_loop[(minutes - start) % grid_loop.length]
      end

      previous << grid
    end

    grid
  end

  def resource_value(grid)
    grouped = grid.flatten.group_by { |i| i }

    grouped["|"].count * grouped["#"].count
  end

  def transform(grid)
    new_grid = Array.new(grid.length) { Array.new(grid[0].length) }

    grid.each.with_index do |row, y|
      row.each.with_index do |acre, x|
        neighbours = get_neighbours(grid, x, y).compact
        counts = neighbours.reduce(Hash.new(0)) { |h, k| h[k] += 1; h }

        new_grid[y][x] = acre

        if acre == "."
          new_grid[y][x] = "|" if counts["|"] >= 3
        elsif acre == "|"
          new_grid[y][x] = "#" if counts["#"] >= 3
        elsif acre == "#"
          new_grid[y][x] = "." unless counts["#"] >= 1 && counts["|"] >= 1
        end
      end
    end

    new_grid
  end

  def get_neighbours(grid, x, y)
    neighbours = (y-1..y+1).map do |yy|
      (x-1..x+1).map do |xx|
        if xx >= 0 && yy >= 0 && yy < grid.length && xx < grid[0].length
          grid[yy][xx] unless xx == x && yy == y
        end
      end
    end

    neighbours.flatten
  end

  def display(grid)
    grid.each { |row| puts row.join }
    puts ""
  end

  def parse(input)
    input.split("\n").map { |row| row.strip.chars }
  end
end