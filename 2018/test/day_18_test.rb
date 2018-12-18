require "test_helper"
require "day_18"

class Day18Test < Minitest::Test
  def setup
    @day_18 = Day18.new
  end

  def test_part1
    assert_equal 1147, @day_18.part1(sample_input_1)
    assert_equal 621205, @day_18.part1(input("day_18.txt"))
  end

  def test_part2
    assert_equal 228490, @day_18.part2(input("day_18.txt"))
  end

  def sample_input_1
    ".#.#...|#.
    .....#|##|
    .|..|...#.
    ..|#.....#
    #.#|||#|#|
    ...#.||...
    .|....|...
    ||...#|.#|
    |.||||..|.
    ...#.|..|."
  end
end
