# frozen_string_literal: true

require "test_helper"
require "day_18"

class Day18Test < Minitest::Test
  def test_part1
    day = Day18.new

    assert_equal 4140, day.part1(input("day_18_example_4"))
    assert_equal 4173, day.part1(input("day_18"))
  end

  def test_part2
    day = Day18.new

    assert_equal 3993, day.part2(input("day_18_example_4"))
    # assert_equal 4173, day.part1(input("day_18"))
  end

  def test_reduce
    day = Day18.new

    assert_equal [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]], day.reduce([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])
  end

  def test_magnitude
    day = Day18.new

    assert_equal 143, day.magnitude([[1, 2], [[3, 4], 5]])
    assert_equal 1384, day.magnitude([[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]])
    assert_equal 445, day.magnitude([[[[1, 1], [2, 2]], [3, 3]], [4, 4]])
    assert_equal 791, day.magnitude([[[[3, 0], [5, 3]], [4, 4]], [5, 5]])
    assert_equal 1137, day.magnitude([[[[5, 0], [7, 4]], [5, 5]], [6, 6]])
    assert_equal 3488, day.magnitude([[[[8, 7], [7, 7]], [[8, 6], [7, 7]]], [[[0, 7], [6, 6]], [8, 7]]])
    assert_equal 4140, day.magnitude([[[[6, 6], [7, 6]], [[7, 7], [7, 0]]], [[[7, 7], [7, 7]], [[7, 8], [9, 9]]]])
  end

  def test_explode
    day = Day18.new

    assert_equal [[[[0, 9], 2], 3], 4], day.explode([[[[[9, 8], 1], 2], 3], 4])
    assert_equal [7, [6, [5, [7, 0]]]], day.explode([7, [6, [5, [4, [3, 2]]]]])
    assert_equal [[6, [5, [7, 0]]], 3], day.explode([[6, [5, [4, [3, 2]]]], 1])
    assert_equal [[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]], day.explode([[3, [2, [1, [7, 3]]]], [6, [5, [4, [3, 2]]]]])
    assert_equal [[3, [2, [8, 0]]], [9, [5, [7, 0]]]], day.explode([[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]])
    assert_equal [[[[4, 0], [5, 4]], [[0, [7, 6]], [9, 5]]], [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]],
                 day.explode([[[[4, 0], [5, 0]], [[[4, 5], [2, 6]], [9, 5]]],
                              [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]])
  end

  def test_split
    day = Day18.new

    assert_equal [[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]], day.split([[[[0, 7], 4], [15, [0, 13]]], [1, 1]])
    assert_equal [[[[0, 7], 4], [[7, 8], [0, [6, 7]]]], [1, 1]], day.split([[[[0, 7], 4], [[7, 8], [0, 13]]], [1, 1]])
  end

  def test_part2
    day = Day18.new

    # assert_equal 1, day.part2(input("day_18_example_1"))
    # assert_equal 1, day.part2(input("day_18"))
  end
end
