class Day07
  def part1(input)
    positions = positions(input)
    median = median(positions)

    positions
      .map { (median - _1).abs }
      .sum
  end

  def part2(input)
    positions = positions(input)
    mean = mean(positions)

    [mean.floor, mean.ceil]
      .map do |m|
        positions
          .map { (m - _1).abs }
          .map { (1.._1).sum }
          .sum
      end
      .min
  end

  def positions(input)
    input.split(",").map(&:to_i)
  end

  def median(positions)
    sorted = positions.sort
    mid = positions.count / 2
    sorted.count.even? ? sorted[mid - 1, 2].sum / 2 : sorted[mid]
  end

  def mean(positions)
    positions.sum / positions.count.to_f
  end
end
