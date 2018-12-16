require "test_helper"
require "day_16"

class Day16Test < Minitest::Test
  def setup
    @day_16 = Day16.new
  end

  def test_part1
    assert_equal 1, @day_16.part1(sample_input_1)
    assert_equal 590, @day_16.part1(input("day_16_1.txt"))
  end

  def test_part1
    assert_equal 475, @day_16.part2(input("day_16_1.txt"), input("day_16_2.txt"))
  end

  def test_parse
    assert_equal [[[3, 2, 1, 1], [9, 2, 1, 2], [3, 2, 2, 1]]], @day_16.parse(sample_input_1)
    assert_equal [[[3, 3, 2, 3], [3, 1, 2, 2], [3, 3, 2, 3]], [[1, 3, 0, 1], [12, 0, 2, 3], [1, 3, 0, 0]]], @day_16.parse(input("day_16_1.txt")).first(2)
  end

  def sample_reg_1
    [3, 2, 1, 1]
  end

  def sample_input_1
    "Before: [3, 2, 1, 1]
    9 2 1 2
    After:  [3, 2, 2, 1]"
  end
end
