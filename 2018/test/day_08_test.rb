require "test_helper"
require "day_08"

class Day08Test < Minitest::Test
  def setup
    @day_08 = Day08.new
  end

  def test_part_1
    assert_equal 138, @day_08.part1(sample_input_1)
    assert_equal 43996, @day_08.part1(input("day_08.txt"))
  end

  def test_part_2
    assert_equal 66, @day_08.part2(sample_input_1)
    assert_equal 35189, @day_08.part2(input("day_08.txt"))
  end

  def test_numbers
    assert_equal sample_input_1_numbers, @day_08.numbers(sample_input_1)
  end

  def sample_input_1
    "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"
  end

  def sample_input_1_numbers
    [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]
  end
end
