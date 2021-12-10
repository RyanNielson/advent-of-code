class Day10
  PAIRS_REGEX = /\(\)|\[\]|\{\}|<>/
  CLOSING_REGEX = /\)|\]|\}|>/
  POINTS_1 = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25_137 }.freeze
  POINTS_2 = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }.freeze

  def part1(input)
    reduced_lines(input)
      .filter { corrupted?(_1) }
      .map { _1[CLOSING_REGEX] }
      .sum { POINTS_1[_1] }
  end

  def part2(input)
    reduced_lines(input)
      .reject { corrupted?(_1) }
      .map { _1.reverse.gsub("(", ")").gsub("[", "]").gsub("{", "}").gsub("<", ">") }
      .map { _1.chars.reduce(0) { |score, char| (score * 5) + POINTS_2[char] } }
      .sort
      .then { _1[_1.length / 2] }
  end

  def reduced_lines(input)
    input
      .split
      .map do |line|
        line.gsub!(PAIRS_REGEX, "") while line.match?(PAIRS_REGEX)
        line
      end
  end

  def corrupted?(line)
    line.match?(CLOSING_REGEX)
  end
end
