require "test_helper"
require "day_14"

class Day14Test < Minitest::Test
  def setup
    @day_14 = Day14.new
  end

  def test_part1
    assert_equal "5158916779", @day_14.part1(9)
    assert_equal "0124515891", @day_14.part1(5)
    assert_equal "9251071085", @day_14.part1(18)
    assert_equal "5941429882", @day_14.part1(2018)
    assert_equal "8610321414", @day_14.part1(input_integer("day_14.txt"))
  end

  def test_part2
    assert_equal 9, @day_14.part2("51589")
    assert_equal 5, @day_14.part2("01245")
    assert_equal 18, @day_14.part2("92510")
    assert_equal 2018, @day_14.part2("59414")
    assert_equal 20258123, @day_14.part2(input("day_14.txt"))
  end
end
