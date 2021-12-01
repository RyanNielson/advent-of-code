# frozen_string_literal: true

require "test_helper"
require "day_01"

class Day01Test < Minitest::Test
  def test_part01
    day01 = Day01.new

    assert_equal 7, day01.part1(input("day_01_example_1"))
    assert_equal 1602, day01.part1(input("day_01"))
  end

  def test_part02
    day01 = Day01.new

    assert_equal 5, day01.part2(input("day_01_example_1"))
    assert_equal 1633, day01.part2(input("day_01"))
  end
end
