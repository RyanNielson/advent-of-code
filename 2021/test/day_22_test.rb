# frozen_string_literal: true

require "test_helper"
require "day_22"

class Day22Test < Minitest::Test
  def test_part1
    day = Day22.new

    assert_equal 39, day.part1(input("day_22_example_1"))
    assert_equal 590_784, day.part1(input("day_22_example_2"))
    assert_equal 582_644, day.part1(input("day_22"))
  end

  def test_part2
    day = Day22.new
    # assert_equal 39, day.part2(input("day_22_example_1"))
    # assert_equal 2_758_514_936_282_235, day.part2(input("day_22_example_3"))
    # assert_equal 1, day.part2(input("day_22"))
  end
end
