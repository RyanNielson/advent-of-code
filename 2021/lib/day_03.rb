class Day03
  def part1(input)
    values = input
             .split("\n")
             .map(&:chars)
             .transpose

    gamma_rate(values) * epsilon_rate(values)
  end

  def part2(input)
    input
      .split("\n")
      .map(&:chars)
      .then { life_support_rating(_1) }
  end

  private

  def life_support_rating(values)
    num_bits = values.map(&:length).max
    calculate_rating(values, num_bits, :most_common) * calculate_rating(values, num_bits, :least_common)
  end

  def calculate_rating(values, num_bits, type)
    num_bits.times do |i|
      bits = values.transpose[i]
      bit = method(type).call(bits)
      values = values.filter { |num| num[i] == bit }
      break if values.count == 1
    end

    values.flatten.join.to_i(2)
  end

  def most_common(bits)
    counts = bits.tally

    return "1" if counts["0"] == counts["1"]

    counts
      .max_by { |_k, v| v }
      .first
  end

  def least_common(bits)
    counts = bits.tally

    return "0" if counts["0"] == counts["1"]

    counts
      .min_by { |_k, v| v }
      .first
  end

  def gamma_rate(value)
    value
      .map { |i| i.max_by { |c| i.count(c) } }
      .join
      .to_i(2)
  end

  def epsilon_rate(value)
    value
      .map { |i| i.min_by { |c| i.count(c) } }
      .join
      .to_i(2)
  end
end
