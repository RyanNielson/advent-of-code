# frozen_string_literal: true

require "test_helper"
require "day_15"

class Day15Test < Minitest::Test
  def test_part1
    day = Day15.new

    assert_equal 40, day.part1(input("day_15_example_1"))
    assert_equal 619, day.part1(input("day_15"))
  end

  def test_part2
    day = Day15.new

    assert_equal 315, day.part2(input("day_15_example_1"))
    assert_equal 2922, day.part2(input("day_15"))
  end
end
