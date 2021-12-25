# frozen_string_literal: true

require "test_helper"
require "day_25"

class Day25Test < Minitest::Test
  def test_part1
    day = Day25.new

    assert_equal 58, day.part1(input("day_25_example_1"))
    assert_equal 453, day.part1(input("day_25"))
  end

  def test_part2
    day = Day25.new

    assert_equal 1, day.part2(input("day_25_example_1"))
    # assert_equal 1, day.part2(input("day_25"))
  end
end
