require "test_helper"
require "day_02"

class Day02Test < Minitest::Test
  def setup
    @day_02 = Day02.new
  end

  def test_has_count?
    assert_equal false, @day_02.has_count?("abcdef", 2)
    assert_equal true, @day_02.has_count?("bababc", 2)
    assert_equal true, @day_02.has_count?("abbcde", 2)
    assert_equal false, @day_02.has_count?("abcccd", 2)
    assert_equal true, @day_02.has_count?("aabcdd", 2)
    assert_equal true, @day_02.has_count?("abcdee", 2)
    assert_equal false, @day_02.has_count?("ababab", 2)

    assert_equal false, @day_02.has_count?("abcdef", 3)
    assert_equal true, @day_02.has_count?("bababc", 3)
    assert_equal false, @day_02.has_count?("abbcde", 3)
    assert_equal true, @day_02.has_count?("abcccd", 3)
    assert_equal false, @day_02.has_count?("aabcdd", 3)
    assert_equal false, @day_02.has_count?("abcdee", 3)
    assert_equal true, @day_02.has_count?("ababab", 3)
  end

  def test_two_count
    assert_equal 4, @day_02.num_count(sample_input_1.split, 2)
  end

  def test_three_count
    assert_equal 3, @day_02.num_count(sample_input_1.split, 3)
  end

  def test_part1
    assert_equal 12, @day_02.part1(sample_input_1)
    assert_equal 6370, @day_02.part1(input("day_02.txt"))
  end

  def test_difference_count
    assert_equal 2, @day_02.difference_count("abcde", "axcye")
    assert_equal 1, @day_02.difference_count("fghij", "fguij")
  end

  def test_remove_differing_characters
    assert_equal "ace", @day_02.remove_differing_characters("abcde", "axcye")
    assert_equal "fgij", @day_02.remove_differing_characters("fghij", "fguij")
  end

  def test_part2
    assert_equal "fgij", @day_02.part2(sample_input_2)
    # assert_equal "rmyxgdlihczskunpfijqcebtv", @day_02.part2(input("day_02.txt"))
  end

  def sample_input_1
    "abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab"
  end

  def sample_input_2
    "abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz"
  end
end
