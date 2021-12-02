# frozen_string_literal: true

require "test_helper"
require "day_02"

class Day02Test < Minitest::Test
  def test_part1
    day = Day02.new

    assert_equal 150, day.part1(input("day_02_example_1"))
    assert_equal 1_604_850, day.part1(input("day_02"))
  end

  def test_part2
    day = Day02.new

    assert_equal 900, day.part2(input("day_02_example_1"))
    assert_equal 1685186100, day.part2(input("day_02"))
  end
end
