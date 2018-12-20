require "test_helper"
require "day_20"

class Day20Test < Minitest::Test
  def setup
    @day_20 = Day20.new
  end

  def test_part1
    assert_equal 3, @day_20.part1(sample_input_1)
    assert_equal 18, @day_20.part1(sample_input_3)
    assert_equal 23, @day_20.part1(sample_input_4)
    assert_equal 31, @day_20.part1(sample_input_5)
    assert_equal 3672, @day_20.part1(input("day_20.txt"))
  end

  def test_part2
    assert_equal 8586, @day_20.part2(input("day_20.txt"))
  end

  def test_parse
    assert_equal ["W", "N", "E"], @day_20.parse(sample_input_1)
    assert_equal ["E", "N", "W", "W", "W", "(", "N", "E", "E", "E", "|", "S", "S", "E", "(", "E", "E", "|", "N", ")", ")"], @day_20.parse(sample_input_2)
  end

  def sample_input_1
    "^WNE$"
  end

  def sample_input_2
    "^ENWWW(NEEE|SSE(EE|N))$"
  end

  def sample_input_3
    "^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$"
  end

  def sample_input_4
    "^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$"
  end

  def sample_input_5
    "^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$"
  end
end
