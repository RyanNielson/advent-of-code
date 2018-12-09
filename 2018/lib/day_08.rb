class Day08
  def part1(input)
    metadata_sum(numbers(input));
  end

  def part2(input)
    child_sums(numbers(input));
  end

  def metadata_sum(nums)
    child_count, metadata_count = nums.shift(2)

    sum = child_count.times.map { metadata_sum(nums) }.sum

    sum + nums.shift(metadata_count).sum
  end

  def child_sums(nums)
    child_count, metadata_count = nums.shift(2)

    child_sums = child_count.times.map { child_sums(nums) }
    metadata   = nums.shift(metadata_count)
    
    if child_count == 0
      metadata.sum
    else
      metadata.map{ |i| child_sums[i - 1] }.compact.sum
    end
  end

  def numbers(input)
    input.split.map(&:to_i)
  end
end
