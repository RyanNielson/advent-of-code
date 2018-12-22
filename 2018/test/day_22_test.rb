require "test_helper"
require "day_22"

class Day22Test < Minitest::Test
  def setup
    @day_22 = Day22.new
  end

  def test_part1
    assert_equal 114, @day_22.part1(510, 10, 10)
    assert_equal 10603, @day_22.part1(6084, 14, 709)
  end
end
