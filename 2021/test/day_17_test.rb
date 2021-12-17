# frozen_string_literal: true

require "test_helper"
require "day_17"

class Day17Test < Minitest::Test
  def test_part1
    day = Day17.new

    assert_equal 45, day.part1(input("day_17_example_1"))
    assert_equal 2775, day.part1(input("day_17"))
  end

  def test_part2
    day = Day17.new

    assert_equal 112, day.part2(input("day_17_example_1"))
    assert_equal 1566, day.part2(input("day_17"))
  end
end
