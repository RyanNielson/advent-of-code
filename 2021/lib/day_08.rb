class Day08
  def part1(input)
    input
      .split("\n")
      .map { |entry| entry.split(" | ")[1].split }
      .flatten
      .count { |digit| [2, 3, 4, 7].include?(digit.length) }
  end

  def part2(input)
    # split_input = input.split.map(&:to_i)
  end
end
