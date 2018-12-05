class Day05
  def part1(input)
    remove_reacting_units(input).size
  end

  def part2(input)
    ("a".."z").map do |remove|
      remove_reacting_units(input.gsub(/#{remove}/i, "")).size
    end.min
  end

  def remove_reacting_units(polymer)
    polymer.chars.reduce("") do |result, unit|
      if result.empty? || !opposite_polarity?("#{result[-1]}#{unit}")
        result << unit
      else
        result[0...-1]
      end
    end
  end

  def opposite_polarity?(unit)
    a, b = unit.split(//)

    a.casecmp?(b) && (a.swapcase != b.swapcase)
  end
end
