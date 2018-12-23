require "test_helper"
require "day_23"

class Day23Test < Minitest::Test
  def setup
    @day_23 = Day23.new
  end

  def test_part1
    assert_equal 7, @day_23.part1(sample_input_1)
    assert_equal 1, @day_23.part1(input("day_23.txt"))
  end

  def test_part1
    assert_equal 36, @day_23.part2(sample_input_2)
    assert_equal 1, @day_23.part2(input("day_23.txt"))
  end

  def sample_input_1
    "pos=<0,0,0>, r=4
    pos=<1,0,0>, r=1
    pos=<4,0,0>, r=3
    pos=<0,2,0>, r=1
    pos=<0,5,0>, r=3
    pos=<0,0,3>, r=1
    pos=<1,1,1>, r=1
    pos=<1,1,2>, r=1
    pos=<1,3,1>, r=1"
  end

  def sample_input_2
    "pos=<10,12,12>, r=2
    pos=<12,14,12>, r=2
    pos=<16,12,12>, r=4
    pos=<14,14,14>, r=6
    pos=<50,50,50>, r=200
    pos=<10,10,10>, r=5"
  end
end
