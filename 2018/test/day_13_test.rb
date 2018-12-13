require "test_helper"
require "day_13"

class Day13Test < Minitest::Test
  def setup
    @day_13 = Day13.new
  end

  def test_part1
    assert_equal "0,3", @day_13.part1(sample_input_1)
    assert_equal "7,3", @day_13.part1(sample_input_2)
    assert_equal "102,114", @day_13.part1(input_no_strip("day_13.txt"))
  end

  def test_part2
    assert_equal "6,4", @day_13.part2(sample_input_3)
    assert_equal "146,87", @day_13.part2(input_no_strip("day_13.txt"))
  end

  def test_parse
    _, tracks = @day_13.parse(sample_input_1)
    _, tracks2 = @day_13.parse(sample_input_2)

    assert_equal [["|"], ["|"], ["|"], ["|"], ["|"], ["|"], ["|"]], tracks
    assert_equal [["/", "-", "-", "-", "\\"], ["|", " ", " ", " ", "|", " ", " ", "/", "-", "-", "-", "-", "\\"], ["|", " ", "/", "-", "+", "-", "-", "+", "-", "\\", " ", " ", "|"], ["|", " ", "|", " ", "|", " ", " ", "|", " ", "|", " ", " ", "|"], ["\\", "-", "+", "-", "/", " ", " ", "\\", "-", "+", "-", "-", "/"], [" ", " ", "\\", "-", "-", "-", "-", "-", "-", "/"]], tracks2
  end

  def sample_input_1
    "|
v
|
|
|
^
|"
  end

  def sample_input_2
    %q(/->-\
|   |  /----\
| /-+--+-\  |
| | |  | v  |
\-+-/  \-+--/
  \------/)
  end

  def sample_input_3
    %q(/>-<\
|   |
| /<+-\
| | | v
\>+</ |
  |   ^
  \<->/)
  end
end
