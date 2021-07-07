require "set"

class Day01
  def part1(input)
    input.split(//).sum do |v| 
      case v
      when "(" then 1
      when ")" then -1
      end
    end
  end

  def part2(input)
    input.split(//).each_with_index.reduce(0) do |acc, (v, i)|
      acc += case v
      when "(" then 1
      when ")" then -1
      end

      break (i + 1) if acc < 0

      acc
    end
  end
end
