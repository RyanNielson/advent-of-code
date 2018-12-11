require "test_helper"
require "day_11"

class Day11Test < Minitest::Test
  def setup
    @day_11 = Day11.new
  end

  def test_part1
    assert_equal "33,45", @day_11.part1(sample_input_1)
    assert_equal "21,61", @day_11.part1(sample_input_2)
    assert_equal "243,49", @day_11.part1(input("day_11.txt"))
    # assert_equal [[33, 45], 29], @day_11.part1(sample_input_1)
    # assert_equal [[21, 61], 30], @day_11.part1(sample_input_2)
    # assert_equal [[243, 49], 31], @day_11.part1(input("day_11.txt"))
  end

  def test_part2
    assert_equal "90,269,16", @day_11.part2(sample_input_1)
    # assert_equal "232,251,12", @day_11.part2(sample_input_2)
    # assert_equal "243,49", @day_11.part2(input("day_11.txt"))
  end

  def test_power_level
    assert_equal 4, @day_11.power_level([3, 5], 8)
    assert_equal -5, @day_11.power_level([122, 79], 57)
    assert_equal 0, @day_11.power_level([217, 196], 39)
    assert_equal 4, @day_11.power_level([101, 153], 71)
  end

  def sample_input_1
    "18"
  end

  def sample_input_2
    "42"
  end
end
