class Day01
  def part1(input)
    measurements = input.split.map(&:to_i)
    zipped = measurements[..-2].zip(measurements[1..])
    zipped.select { |x, y| y > x }.count
  end

  def part2(input)
    measurements = input.split.map(&:to_i)
    summed = measurements[..-3].zip(measurements[1..-2], measurements[2..]).map(&:sum)
    zipped_summed = summed[..-2].zip(summed[1..])
    zipped_summed.select { |x, y| y > x }.count
  end
end
