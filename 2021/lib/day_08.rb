# require "set"

class Entry
  def initialize(input)
    @patterns, @digits = input.split(" | ").map(&:split)
  end

  def output
    digits = initial_mappings
    digits = five_digit_mappings(digits)
    digits = six_digit_mappings(digits)

    mapped_digits = digits.each_with_object({}) do |(key, val), accum|
      accum[val.to_a.sort.join] = key
    end

    @digits
      .map { |digit| mapped_digits[digit.chars.sort.join].to_s }
      .join
      .to_i
  end

  def initial_mappings
    digits = {}

    @patterns.each do |pattern|
      case pattern.length
      when 2
        digits[1] = pattern.chars
      when 3
        digits[7] = pattern.chars
      when 4
        digits[4] = pattern.chars
      when 7
        digits[8] = pattern.chars
      end
    end

    digits
  end

  def five_digit_mappings(digits)
    @patterns
      .filter { _1.length == 5 }
      .map { _1.chars.to_set }
      .each_with_object(digits) do |digit, digit_acc|
        if digit.intersection(digit_acc[1]).length == 1 && digit.intersection(digit_acc[4]).length == 2
          digit_acc[2] = digit
        elsif digit.intersection(digit_acc[7]).length == 3
          digit_acc[3] = digit
        elsif digit.intersection(digit_acc[1]).length == 1 && digit.intersection(digit_acc[4]).length == 3
          digit_acc[5] = digit
        end
      end
  end

  def six_digit_mappings(digits)
    @patterns
      .filter { _1.length == 6 }
      .map { _1.chars.to_set }
      .each_with_object(digits) do |digit, digit_acc|
        if digit.intersection(digit_acc[1]).length == 1
          digit_acc[6] = digit
        elsif digit.intersection(digit_acc[4]).length == 4
          digit_acc[9] = digit
        elsif digit.intersection(digit_acc[4]).length == 3
          digit_acc[0] = digit
        end
      end

    digits
  end
end

class Day08
  def part1(input)
    input
      .split("\n")
      .map { |entry| entry.split(" | ")[1].split }
      .flatten
      .count { |digit| [2, 3, 4, 7].include?(digit.length) }
  end

  def part2(input)
    input
      .split("\n")
      .map { |entry| Entry.new(entry) }
      .map(&:output)
      .sum
  end
end
