class Day20
  def part1(input)
    facility(input).values.max
  end

  def part2(input)
    facility(input).values.select{ |v| v >= 1000 }.count
  end

  def facility(input)
    distance = 0
    position = [0, 0]
    stack = []

    parse(input).reduce(Hash[position => distance]) do |grid, step|
      case step
      when "(" then stack << [position, distance]
      when ")" then position, distance = stack.pop()
      when "|" then position, distance = stack[-1]
      else
        position = position.zip(delta(step)).map{|x, y| x + y}
        distance += 1

        grid[position] = distance if !grid.has_key?(position) || distance < grid[position]
      end

      grid
    end
  end

  def delta(direction)
    case direction
    when "N" then [0, 1]
    when "S" then [0, -1]
    when "E" then [1, 0]
    when "W" then [-1, 0]
    else [0, 0]
    end
  end

  def parse(input)
    input.chars[1...-1]
  end
end