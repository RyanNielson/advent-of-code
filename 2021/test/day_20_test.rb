# frozen_string_literal: true

require "test_helper"
require "day_20"

class Day20Test < Minitest::Test
  def test_part1
    day = Day20.new

    assert_equal 35, day.part1(input("day_20_example_1"))
    assert_equal 5306, day.part1(input("day_20"))
  end

  def test_part2
    day = Day20.new

    assert_equal 3351, day.part2(input("day_20_example_1"))
    assert_equal 17_497, day.part2(input("day_20"))
  end
end
