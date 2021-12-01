class Day01
  def part1(input)
    measurements = input.split.map(&:to_i)
    measurements[..-2].zip(measurements[1..]).count { |x, y| y > x }
  end

  def part2(input)
    measurements = input.split.map(&:to_i)
    summed = measurements[..-3].zip(measurements[1..-2], measurements[2..]).map(&:sum)
    summed[..-2].zip(summed[1..]).count { |x, y| y > x }
  end
end
