# require "active_support"
require "active_support/all"

class Day18
  def part1(input)
    numbers = parse_numbers(input)

    result = numbers.reduce do |first, second|
      reduce([first, second])
    end

    magnitude(result)
  end

  def part2(input)
    p "RYAN"
    numbers = parse_numbers(input)

    # numbers.combinations(2).to_a

    # result = numbers.reduce do |first, second|
    #   reduce([first, second])
    # end

    # magnitude(result)
  end

  def reduce(number)
    p ""
    p number
    # original_number = number.clone
    new_number = number.deep_dup
    loop do
      # changed = false
      p "=="
      starting_number = new_number.deep_dup
      p new_number
      new_number = explode(new_number)
      # p new_number
      # p "EXPLODE"
      # p starting_number
      # p new_number

      if starting_number != new_number
        # Explode occured, to start over
        p "EXPLODE OCCURED"
        p new_number
        next
      end

      new_number = split(new_number)
      # p "SPLIT"
      # p new_number
      if starting_number == new_number
        # split didn't occur so stop
        break
      else
        p "SPLIT OCCURRED"
        p new_number
      end
    end

    # Explode

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
    number_to_split = flatten_array_with_indices(number, []).each_slice(2).select do |(number, _indices)|
      number >= 10
    end.first

    return number if number_to_split.nil?

    # if number_to_split
    num, indices = number_to_split
    new_pair = [(num / 2.0).floor, (num / 2.0).ceil]
    indices_string = indices.map { |i| "[#{i}]" }.join
    eval("number#{indices_string} = #{new_pair}")
    # end

    number
  end

  def flatten_array_with_indices(pair, indices)
    return [pair, indices]  if pair.is_a?(Integer)

    pair.each_with_index.map do |pair2, i|
      flatten_array_with_indices(pair2, indices + [i]) # .flatten(2)
    end.flatten(1)
  end

  # [[[[4, 0], [5, 0]], [[[4, 5], [2, 6]], [9, 5]]], [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]]
  # EXPLODES
  # PAIR [4, 5]

  # [[[[4, 0], [5, 4]], [[0, [7, 6]], [9, 5]]], [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]]

  # WHAT IM GETTING
  # [[[[4, 0], [5, 4]], [[0, [2, 6]], [14, 5]]], [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]]

  def explode(number)
    flattened_number = flatten_array_with_indices(number, []).each_slice(2).map { |a| a }
    first_nested_4_deep = nil
    regular_number_left = nil
    regular_number_right = nil

    flattened_number.each_cons(2).each_with_index do |(item1, item2), i|
      value1, indices1 = item1
      value2, indices2 = item2

      next unless indices1.count == 5 && indices2.count == 5 && indices1.last == 0 && indices2.last == 1

      first_nested_4_deep = [item1, item2]
      # first_nested_4_deep_values = [value1, value2]
      # first_nested_4_deep_indices = [indices1, indices2]

      # TODO: BETTER HANDLE WHEN THERE'S NO NUMBER TO THE LEFT. IN THE FIRST EXAMPLE ITS RETURNING 4 WHEN IT SHOULD BE NOTHING.
      # p i
      # p i - 1
      # p flattened_number[i - 1]
      left_index = i - 1
      right_index = i + 2
      regular_number_left = flattened_number[left_index] if left_index >= 0 && left_index < flattened_number.count
      regular_number_right = flattened_number[right_index] if right_index >= 0 && right_index < flattened_number.count
      break
    end

    # p flattened_number
    # p first_nested_4_deep
    # p regular_number_left
    # p regular_number_right
    # p first_nested_4_deep[0][1]

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

    p first_nested_4_deep
    indices_to_replace = first_nested_4_deep[0][1][0..-2]
    indices_string = indices_to_replace.map { |i| "[#{i}]" }.join
    eval("number#{indices_string} = 0")

    number
    # p indices_to_replace
    # first_nested_4_deep[0][0]
    # eval("number#{indices_string} = #{num + first_nested_4_deep[1][0]}")

    #   unless left_number.nil?
    #     num, indices = left_number
    #     indices_string = indices.map { |i| "[#{i}]" }.join
    #     eval("number#{indices_string} = #{num + first_nested_4_deep[0]}")
    #   end

    #   unless right_number.nil?
    #     num, indices = right_number
    #     indices_string = indices.map { |i| "[#{i}]" }.join
    #     eval("number#{indices_string} = #{num + first_nested_4_deep[1]}")
    #   end

    #   number[index1][index2][index3][index4] = 0

    # could go through each pair in above, find ones with 5 indices next to eachother, then that's the pair
    # could find first value left by taking the indice of the first above and getting the first to the left
    # could find first value right by taking the indice of the second above, and getting the first to the right.
  end

  # TODO: PLEASE refactor if this works. It's scary.
  # def explode(number)
  #   first_nested_4_deep = nil
  #   regular_numbers_left = []
  #   regular_numbers_right = []
  #   index1 = nil
  #   index2 = nil
  #   index3 = nil
  #   index4 = nil

  #   number.each_with_index do |level1, i|
  #     if level1.is_a?(Integer)
  #       if first_nested_4_deep.nil?
  #         regular_numbers_left << [level1, [i]]
  #       else
  #         regular_numbers_right << [level1, [i]]
  #       end
  #       next
  #     end

  #     level1.each_with_index do |level2, j|
  #       if level2.is_a?(Integer)
  #         if first_nested_4_deep.nil?
  #           regular_numbers_left << [level2, [i, j]]
  #         else
  #           regular_numbers_right << [level2, [i, j]]
  #         end
  #         next
  #       end

  #       level2.each_with_index do |level3, k|
  #         if level3.is_a?(Integer)
  #           if first_nested_4_deep.nil?
  #             regular_numbers_left << [level3, [i, j, k]]
  #           else
  #             regular_numbers_right << [level3, [i, j, k]]
  #           end
  #           next
  #         end

  #         level3.each_with_index do |level4, l|
  #           if level4.is_a?(Integer)
  #             if first_nested_4_deep.nil?
  #               regular_numbers_left << [level4, [i, j, k, l]]
  #             else
  #               regular_numbers_right << [level4, [i, j, k, l]]
  #             end
  #             next
  #           end

  #           # TODO: Use pattern matching instead?
  #           next unless first_nested_4_deep.nil? && level4.is_a?(Array) && level4.count == 2 && level4.all? do |item|
  #                         item.is_a?(Integer)
  #                       end

  #           # next unless first_nested_4_deep.nil?

  #           # first_nested_4_deep = level4 # if first_nested_4_deep.nil?
  #           first_nested_4_deep = level4 if first_nested_4_deep.nil?

  #           # TODO: Maybe just store these in array.
  #           index1 = i
  #           index2 = j
  #           index3 = k
  #           index4 = l
  #         end
  #       end
  #     end
  #   end

  #   stuff = flatten_array_with_indices(number, []).each_slice(2).map { |a| a }
  #   # could go through each pair in above, find ones with 5 indices next to eachother, then that's the pair
  #   # could find first value left by taking the indice of the first above and getting the first to the left
  #   # could find first value right by taking the indice of the second above, and getting the first to the right.

  #   p first_nested_4_deep
  #   p regular_numbers_left
  #   p regular_numbers_right # ITS NOT GETTING ALL THE RIGHT VALUES
  #   p stuff
  #   return number if first_nested_4_deep.nil?

  #   left_number = regular_numbers_left.last
  #   right_number = regular_numbers_right.first

  #   unless left_number.nil?
  #     num, indices = left_number
  #     indices_string = indices.map { |i| "[#{i}]" }.join
  #     eval("number#{indices_string} = #{num + first_nested_4_deep[0]}")
  #   end

  #   unless right_number.nil?
  #     num, indices = right_number
  #     indices_string = indices.map { |i| "[#{i}]" }.join
  #     eval("number#{indices_string} = #{num + first_nested_4_deep[1]}")
  #   end

  #   number[index1][index2][index3][index4] = 0

  #   number
  # end

  def parse_numbers(input)
    input.split.map { eval(_1) }
  end
end
