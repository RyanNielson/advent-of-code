# frozen_string_literal: true

require "test_helper"
require "day_05"

class Day05Test < Minitest::Test
  def test_part1
    day = Day05.new

    assert_equal 5, day.part1(input("day_05_example_1"))
    assert_equal 5774, day.part1(input("day_05"))
  end

  def test_part2
    day = Day05.new

    assert_equal 12, day.part2(input("day_05_example_1"))
    assert_equal 18_423, day.part2(input("day_05"))
  end
end
