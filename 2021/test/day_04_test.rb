# frozen_string_literal: true

require "test_helper"
require "day_04"

class Day04Test < Minitest::Test
  def test_part1
    day = Day04.new

    assert_equal 4512, day.part1(input("day_04_example_1"))
    assert_equal 65_325, day.part1(input("day_04"))
  end

  def test_part2
    day = Day04.new

    assert_equal 1924, day.part2(input("day_04_example_1"))
    assert_equal 4624, day.part2(input("day_04"))
  end
end
