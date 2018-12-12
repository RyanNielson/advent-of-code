require "test_helper"
require "day_12"

class Day12Test < Minitest::Test
  def setup
    @day_12 = Day12.new
  end

  def test_part1
    assert_equal 325, @day_12.part1(sample_input_1)
    assert_equal 3472, @day_12.part1(input("day_12.txt"))
  end

  def test_part2
    assert_equal 2600000000919, @day_12.part2(input("day_12.txt"))
  end

  def test_parse
    initial_state, rules = @day_12.parse(sample_input_1)

    assert_equal({0=>"#", 1=>".", 2=>".", 3=>"#", 4=>".", 5=>"#", 6=>".", 7=>".", 8=>"#", 9=>"#", 10=>".", 11=>".", 12=>".", 13=>".", 14=>".", 15=>".", 16=>"#", 17=>"#", 18=>"#", 19=>".", 20=>".", 21=>".", 22=>"#", 23=>"#", 24=>"#"}, initial_state)
    assert_equal({"...##"=>"#", "..#.."=>"#", ".#..."=>"#", ".#.#."=>"#", ".#.##"=>"#", ".##.."=>"#", ".####"=>"#", "#.#.#"=>"#", "#.###"=>"#", "##.#."=>"#", "##.##"=>"#", "###.."=>"#", "###.#"=>"#", "####."=>"#"}, rules)
  end

  def sample_input_1
    "initial state: #..#.#..##......###...###

    ...## => #
    ..#.. => #
    .#... => #
    .#.#. => #
    .#.## => #
    .##.. => #
    .#### => #
    #.#.# => #
    #.### => #
    ##.#. => #
    ##.## => #
    ###.. => #
    ###.# => #
    ####. => #"
  end
end
