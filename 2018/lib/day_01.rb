require "set"

class Day01
  def part1(input)
    split_numbers(input).sum
  end

  def part2(input)
    frequency = 0
    frequencies_reached = Set[0]

    split_numbers(input).cycle do |number|
      frequency += number
      break unless frequencies_reached.add?(frequency)
    end

    frequency
  end

  def split_numbers(input)
    input.split.map(&:to_i)
  end
end
