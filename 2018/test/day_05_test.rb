require "test_helper"
require "day_05"

class Day05Test < Minitest::Test
  def setup
    @day_05 = Day05.new
  end

  def test_part1
    assert_equal 10, @day_05.part1(sample_input_1)
    assert_equal 11894, @day_05.part1(input("day_05.txt"))
  end

  def test_part2
    assert_equal 4, @day_05.part2(sample_input_1)
    assert_equal 5310, @day_05.part2(input("day_05.txt"))
  end

  def test_remove_reacting_units
    assert_equal "dabCBAcaDA", @day_05.remove_reacting_units(sample_input_1)
  end

  def test_opposite_polarity?
    assert @day_05.opposite_polarity?("aA")
    assert @day_05.opposite_polarity?("Aa")
    refute @day_05.opposite_polarity?("aa")
    refute @day_05.opposite_polarity?("AA")
    refute @day_05.opposite_polarity?("aB")
    refute @day_05.opposite_polarity?("Ba")
    refute @day_05.opposite_polarity?("AB")
    refute @day_05.opposite_polarity?("ab")
  end

  def sample_input_1
    "dabAcCaCBAcCcaDA"
  end
end
