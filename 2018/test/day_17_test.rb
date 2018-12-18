require "test_helper"
require "day_17"

class Day17Test < Minitest::Test
  def setup
    @day_17 = Day17.new
  end

  def test_part1
    assert_equal 57, @day_17.part1(sample_input_1)
    assert_equal 41027, @day_17.part1(input("day_17.txt"))
  end

  def test_part2
    assert_equal 29, @day_17.part2(sample_input_1)
    assert_equal 34214, @day_17.part2(input("day_17.txt"))
  end

  def sample_input_1
    "x=495, y=2..7
    y=7, x=495..501
    x=501, y=3..7
    x=498, y=2..4
    x=506, y=1..2
    x=498, y=10..13
    x=504, y=10..13
    y=13, x=498..504"
  end
end
