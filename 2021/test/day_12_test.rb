# frozen_string_literal: true

require "test_helper"
require "day_12"

class Day12Test < Minitest::Test
  def test_part1
    day = Day12.new

    assert_equal 10, day.part1(input("day_12_example_1"))
    assert_equal 19, day.part1(input("day_12_example_2"))
    assert_equal 226, day.part1(input("day_12_example_3"))
    assert_equal 4413, day.part1(input("day_12"))
  end

  def test_part2
    day = Day12.new

    assert_equal 36, day.part2(input("day_12_example_1"))
    assert_equal 103, day.part2(input("day_12_example_2"))
    assert_equal 3509, day.part2(input("day_12_example_3"))
    assert_equal 118_803, day.part2(input("day_12"))
  end
end
