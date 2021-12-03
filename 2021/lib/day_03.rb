class Day03
  def part1(input)
    numbers = numbers(input)
    power_consumption(numbers, :max_by) * power_consumption(numbers, :min_by)
  end

  def part2(input)
    numbers = numbers(input)
    calculate_rating(numbers, :max_by, "1") * calculate_rating(numbers, :min_by, "0")
  end

  private

  def numbers(input)
    input.split("\n").map(&:chars)
  end

  def power_consumption(numbers, comparison)
    numbers
      .transpose
      .map { |i| i.send(comparison) { |c| i.count(c) } }
      .join
      .to_i(2)
  end

  def calculate_rating(values, comparison, default)
    values.map(&:length).max.times do |i|
      bit = bit_criteria(values.transpose[i], comparison, default)
      values = values.filter { |num| num[i] == bit }
      break if values.count == 1
    end

    values.flatten.join.to_i(2)
  end

  def bit_criteria(bits, comparison, default)
    counts = bits.tally

    return default if counts["0"] == counts["1"]

    counts
      .send(comparison) { |_k, v| v }
      .first
  end
end
