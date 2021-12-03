# frozen_string_literal: true

require "test_helper"
require "day_03"

class Day03Test < Minitest::Test
  def test_part1
    day = Day03.new

    assert_equal 198, day.part1(input("day_03_example_1"))
    assert_equal 3_847_100, day.part1(input("day_03"))
  end

  def test_part2
    day = Day03.new

    assert_equal 230, day.part2(input("day_03_example_1"))
    assert_equal 4_105_235, day.part2(input("day_03"))
  end
end
