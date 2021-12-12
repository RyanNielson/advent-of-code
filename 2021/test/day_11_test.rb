# frozen_string_literal: true

require "test_helper"
require "day_11"

class Day11Test < Minitest::Test
  def test_part1
    day = Day11.new

    assert_equal 1656, day.part1(input("day_11_example_1"))
    assert_equal 1705, day.part1(input("day_11"))
  end

  def test_part2
    day = Day11.new

    assert_equal 195, day.part2(input("day_11_example_1"))
    assert_equal 265, day.part2(input("day_11"))
  end
end
