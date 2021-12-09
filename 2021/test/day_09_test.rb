# frozen_string_literal: true

require "test_helper"
require "day_09"

class Day09Test < Minitest::Test
  def test_part1
    day = Day09.new

    assert_equal 15, day.part1(input("day_09_example_1"))
    assert_equal 494, day.part1(input("day_09"))
  end

  def test_part2
    day = Day09.new

    assert_equal 1134, day.part2(input("day_09_example_1"))
    assert_equal 1_048_128, day.part2(input("day_09"))
  end
end
