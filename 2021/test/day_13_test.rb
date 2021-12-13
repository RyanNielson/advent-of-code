# frozen_string_literal: true

require "test_helper"
require "day_13"

class Day13Test < Minitest::Test
  def test_part1
    day = Day13.new

    assert_equal 17, day.part1(input("day_13_example_1"))
    assert_equal 753, day.part1(input("day_13"))
  end

  def test_part2
    day = Day13.new

    visualization = %w[
      #..#.####.#....####.#..#...##.###..#..#
      #..#....#.#....#....#..#....#.#..#.#.#.
      ####...#..#....###..####....#.#..#.##..
      #..#..#...#....#....#..#....#.###..#.#.
      #..#.#....#....#....#..#.#..#.#.#..#.#.
      #..#.####.####.####.#..#..##..#..#.#..#
    ].join("\n")
    assert_equal visualization, day.part2(input("day_13"))
  end
end
