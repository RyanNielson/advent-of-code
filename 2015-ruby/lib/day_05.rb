require 'digest'

class Day05
  def part1(input)
    input.split.count{ |word| three_vowels?(word) && double_letter?(word) && !bad_sequence?(word) }
  end

  def part2(input)
    input.split.count{ |word| repeating_letter?(word) && non_overlapping_pairs?(word)}
  end

  def three_vowels?(word)
    word.scan(/[aeiou]/).length >= 3
  end

  def double_letter?(word)
    word.match?(/(.)\1/)
  end

  def bad_sequence?(word)
    word.match?(/ab|cd|pq|xy/)
  end

  def repeating_letter?(word)
    word.match?(/(.).\1/)
  end

  def non_overlapping_pairs?(word)
    word.match?(/(..).*\1/)
  end
end
