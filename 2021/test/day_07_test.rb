# frozen_string_literal: true

require "test_helper"
require "day_07"

class Day07Test < Minitest::Test
  def test_part1
    day = Day07.new

    assert_equal 37, day.part1(input("day_07_example_1"))
    assert_equal 356_179, day.part1(input("day_07"))
  end

  def test_part2
    day = Day07.new

    assert_equal 168, day.part2(input("day_07_example_1"))
    assert_equal 99_788_435, day.part2(input("day_07"))
  end
end
