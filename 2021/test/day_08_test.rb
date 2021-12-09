# frozen_string_literal: true

require "test_helper"
require "day_08"

class Day08Test < Minitest::Test
  def test_part1
    day = Day08.new

    assert_equal 26, day.part1(input("day_08_example_1"))
    assert_equal 278, day.part1(input("day_08"))
  end

  def test_part2
    day = Day08.new

    assert_equal 5353, day.part2(input("day_08_example_2"))
    assert_equal 61_229, day.part2(input("day_08_example_1"))
    assert_equal 986_179, day.part2(input("day_08"))
  end
end
