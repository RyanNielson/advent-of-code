require "test_helper"
require "day_01"

class Day01Test < Minitest::Test
  def setup
    @day_01 = Day01.new
  end

  def test_part1
    assert_equal 3, @day_01.part1("+1, +1, +1")
    assert_equal 0, @day_01.part1("+1, +1, -2")
    assert_equal (-6), @day_01.part1("-1, -2, -3")
    assert_equal 547, @day_01.part1(input("day_01.txt"))
  end

  def test_part2
    assert_equal 0, @day_01.part2("+1, -1")
    assert_equal 10, @day_01.part2("+3, +3, +4, -2, -4")
    assert_equal 5, @day_01.part2("-6, +3, +8, +5, -6")
    assert_equal 14, @day_01.part2("+7, +7, -2, -7, -4")
    assert_equal 76414, @day_01.part2(input("day_01.txt"))
  end
end
