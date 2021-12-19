require "active_support/all"

# TODO: This needs some serious refactoring, but it works.
class Day18
  def part1(input)
    numbers = parse_numbers(input)
    result = numbers.reduce { |first, second| reduce([first, second]) }
    magnitude(result)
  end

  def part2(input)
    numbers = parse_numbers(input)
    combinations = numbers.combination(2)
    reductions1 = combinations.map { |(first, second)| reduce([first, second]) }
    reductions2 = combinations.map { |(first, second)| reduce([second, first]) }

    (reductions1 + reductions2)
      .map { magnitude(_1) }
      .max
  end

  def reduce(number)
    new_number = number.deep_dup
    loop do
      starting_number = new_number.deep_dup

      new_number = explode(new_number)
      next if starting_number != new_number

      new_number = split(new_number)
      break if starting_number == new_number
    end

    new_number
  end

  def magnitude(sum)
    left, right = sum

    if left.is_a?(Integer) && right.is_a?(Integer)
      (3 * left) + (2 * right)
    elsif left.is_a?(Integer)
      (3 * left) + (2 * magnitude(right))
    elsif right.is_a?(Integer)
      (3 * magnitude(left)) + (2 * right)
    else
      (3 * magnitude(left)) + (2 * magnitude(right))
    end
  end

  def split(number)
    number_to_split = flatten_array_with_indices(number, []).each_slice(2).select do |(value, _indices)|
      value >= 10
    end.first

    return number if number_to_split.nil?

    num, indices = number_to_split
    new_pair = [(num / 2.0).floor, (num / 2.0).ceil]
    indices_string = indices.map { |i| "[#{i}]" }.join
    eval("number#{indices_string} = #{new_pair}")

    number
  end

  def flatten_array_with_indices(pair, indices)
    return [pair, indices]  if pair.is_a?(Integer)

    pair.each_with_index.map do |pair2, i|
      flatten_array_with_indices(pair2, indices + [i]) # .flatten(2)
    end.flatten(1)
  end

  def explode(number)
    flattened_number = flatten_array_with_indices(number, []).each_slice(2).map { |a| a }
    first_nested_4_deep = nil
    regular_number_left = nil
    regular_number_right = nil

    flattened_number.each_cons(2).each_with_index do |(item1, item2), i|
      _, indices1 = item1
      _, indices2 = item2

      next unless indices1.count == 5 && indices2.count == 5 && indices1.last == 0 && indices2.last == 1

      first_nested_4_deep = [item1, item2]

      left_index = i - 1
      right_index = i + 2
      regular_number_left = flattened_number[left_index] if left_index >= 0 && left_index < flattened_number.count
      regular_number_right = flattened_number[right_index] if right_index >= 0 && right_index < flattened_number.count
      break
    end

    return number if first_nested_4_deep.nil?

    unless regular_number_left.nil?
      num, indices = regular_number_left
      indices_string = indices.map { |i| "[#{i}]" }.join
      eval("number#{indices_string} = #{num + first_nested_4_deep[0][0]}")
    end

    unless regular_number_right.nil?
      num, indices = regular_number_right
      indices_string = indices.map { |i| "[#{i}]" }.join
      eval("number#{indices_string} = #{num + first_nested_4_deep[1][0]}")
    end

    indices_to_replace = first_nested_4_deep[0][1][0..-2]
    indices_string = indices_to_replace.map { |i| "[#{i}]" }.join
    eval("number#{indices_string} = 0")

    number
  end

  def parse_numbers(input)
    input.split.map { eval(_1) }
  end
end
