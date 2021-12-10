# frozen_string_literal: true

require "test_helper"
require "day_10"

class Day10Test < Minitest::Test
  def test_part1
    day = Day10.new

    assert_equal 26_397, day.part1(input("day_10_example_1"))
    assert_equal 265_527, day.part1(input("day_10"))
  end

  def test_part2
    day = Day10.new

    assert_equal 288_957, day.part2(input("day_10_example_1"))
    assert_equal 3_969_823_589, day.part2(input("day_10"))
  end
end
