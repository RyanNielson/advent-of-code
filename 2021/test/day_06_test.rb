# frozen_string_literal: true

require "test_helper"
require "day_06"

class Day06Test < Minitest::Test
  def test_part1
    day = Day06.new

    assert_equal 5934, day.part1(input("day_06_example_1"))
    assert_equal 359_344, day.part1(input("day_06"))
  end

  def test_part2
    day = Day06.new

    assert_equal 26_984_457_539, day.part2(input("day_06_example_1"))
    assert_equal 1_629_570_219_571, day.part2(input("day_06"))
  end
end
