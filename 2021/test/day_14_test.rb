# frozen_string_literal: true

require "test_helper"
require "day_14"

class Day14Test < Minitest::Test
  def test_part1
    day = Day14.new

    assert_equal 1588, day.part1(input("day_14_example_1"))
    # assert_equal 2740, day.part1(input("day_14"))
  end

  def test_part2
    day = Day14.new

    # assert_equal 2_188_189_693_529, day.part2(input("day_14_example_1"))
    # assert_equal 2_959_788_056_211, day.part2(input("day_14"))
  end
end
