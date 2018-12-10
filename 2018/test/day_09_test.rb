require "test_helper"
require "day_09"

class Day09Test < Minitest::Test
  def setup
    @day_09 = Day09.new
  end

  def test_part1
    assert_equal 32, @day_09.part1(sample_input_1)
    assert_equal 8317, @day_09.part1(sample_input_2)
    assert_equal 146373, @day_09.part1(sample_input_3)
    assert_equal 2764, @day_09.part1(sample_input_4)
    assert_equal 54718, @day_09.part1(sample_input_5)
    assert_equal 37305, @day_09.part1(sample_input_6)
    assert_equal 386151, @day_09.part1(input("day_09.txt"))
  end

  def test_part2
    assert_equal 3211264152, @day_09.part2(input("day_09.txt"))
  end

  def test_parse
    assert_equal [9, 25], @day_09.parse(sample_input_1)
    assert_equal [459, 71790], @day_09.parse(input("day_09.txt"))
  end

  def sample_input_1
    "9 players; last marble is worth 25 points"
  end

  def sample_input_2
    "10 players; last marble is worth 1618 points"
  end

  def sample_input_3
    "13 players; last marble is worth 7999 points"
  end

  def sample_input_4
    "17 players; last marble is worth 1104 points"
  end

  def sample_input_5
    "21 players; last marble is worth 6111 points"
  end

  def sample_input_6
    "30 players; last marble is worth 5807 points"
  end
end
