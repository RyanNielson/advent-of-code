class Day02
  def part1(input)
    prepare_dimensions(input).map(&method(:wrapping_paper)).sum
  end

  def part2(input)
    prepare_dimensions(input).map(&method(:ribbon)).sum
  end

  def ribbon((l, w, h))
    options = [2 * l + 2 * w, 2 * w + 2 * h, 2 * l + 2 * h]
    options.min + l * w * h
  end

  def wrapping_paper((l, w, h))
    sides = [l * w, w * h, h * l]
    2 * sides.sum + sides.min
  end

  def prepare_dimensions(input) 
    input.split.map{ |v| v.split("x").map(&:to_i) }
  end
end
