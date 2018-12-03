require "test_helper"
require "day_03"

class Day03Test < Minitest::Test
  def setup
    @day_03 = Day03.new
  end

  def test_part1
    assert_equal 4, @day_03.part1(sample_input_1)
    assert_equal 118539, @day_03.part1(input("day_03.txt"))
  end

  def test_part2
    assert_equal 3, @day_03.part2(sample_input_1)
    assert_equal 1270, @day_03.part2(input("day_03.txt"))
  end

  def test_claim_data
    assert_equal [1, 1, 3, 4, 4], @day_03.claim_data("#1 @ 1,3: 4x4")
    assert_equal [2, 3, 1, 4, 4], @day_03.claim_data("#2 @ 3,1: 4x4")
    assert_equal [3, 5, 5, 2, 2], @day_03.claim_data("#3 @ 5,5: 2x2")
  end

  def sample_input_1
    "#1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2"
  end
end
