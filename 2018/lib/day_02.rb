require "set"

class Day02
  def part1(input)
    ids = split_input(input)
    num_count(ids, 2) * num_count(ids, 3)
  end

  def num_count(ids, num)
    count = 0
    ids.each { |id| count += 1 if has_count?(id, num) }
    count
  end

  def has_count?(id, num)
    chars_with_count = id.each_char.select do |char|
      id.count(char) == num
    end

    chars_with_count.uniq.count > 0
  end

  def split_input(input)
    input.split
  end

end
