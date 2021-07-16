require 'digest'

class Day05
  def part1(input)
    prepare_words(input).count{ |word| nice?(word) }
  end

  def nice?(word) 
    three_vowels?(word) && double_letter?(word) && !bad_sequence?(word)
  end

  def three_vowels?(word)
    word.scan(/[aeiou]/).length >= 3
  end

  def double_letter?(word)
    word.match?(/(.)\1/)
  end

  def bad_sequence?(word)
    ['ab', 'cd', 'pq', 'xy'].any?{ |str| word.include?(str) }
  end

  def prepare_words(input) input.split end

  # def part2(input)
  # end
end
