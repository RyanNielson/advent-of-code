class Day03
  def part1(input)
    values = input
             .split("\n")
             .map(&:chars)
             .transpose

    gamma_rate(values) * epsilon_rate(values)
  end

  def part2(input)
    values = input
             .split("\n")
             .map(&:chars)

    oxygen_generator_rating = oxygen_generator_rating(values)
    co2_scrubber_rating = co2_scrubber_rating(values)

    oxygen_generator_rating * co2_scrubber_rating
  end

  private

  def oxygen_generator_rating(values)
    value_length = values
                   .map(&:length)
                   .max

    value_length.times do |i|
      bits = values.transpose[i]
      most_common = most_common(bits)
      values = values.filter { |num| num[i] == most_common }
      break if values.count == 1
    end

    values.flatten.join.to_i(2)
  end

  def co2_scrubber_rating(values)
    value_length = values
                   .map(&:length)
                   .max

    value_length.times do |i|
      bits = values.transpose[i]
      most_common = least_common(bits)
      values = values.filter { |num| num[i] == most_common }
      break if values.count == 1
    end

    values.flatten.join.to_i(2)
  end

  def most_common(bits)
    counts = bits
             .tally

    return "1" if counts["0"] == counts["1"]

    counts
      .max_by { |_k, v| v }
      .first
  end

  def least_common(bits)
    counts = bits
             .tally

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
