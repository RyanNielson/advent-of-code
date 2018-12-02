require "set"

class Day02
  def part1(input)
    ids = split_input(input)
    num_count(ids, 2) * num_count(ids, 3)
  end

  def part2(input)
    ids = split_input(input)

    a = ids.product(ids).each do |id1, id2|
      return remove_differing_characters(id1, id2) if difference_count(id1, id2) == 1
    end
  end

  def num_count(ids, num)
    ids.count { |id| has_count?(id, num) }
  end

  def has_count?(id, num)
    chars_with_count = id.each_char.select do |char|
      id.count(char) == num
    end

    chars_with_count.uniq.count > 0
  end

  def difference_count(id1, id2)
    equivalences = id1.chars.zip(id2.chars).map{ |a, b| a == b }.count(false)
  end

  def remove_differing_characters(id1, id2)
    id1.chars.zip(id2.chars).select{ |a, b| a == b }.transpose.first.join
  end

  def split_input(input)
    input.split
  end
end
