# frozen_string_literal: true

require "test_helper"
require "day_21"

class Day21Test < Minitest::Test
  def test_part1
    day = Day21.new

    assert_equal 739_785, day.part1(input("day_21_example_1"))
    assert_equal 598_416, day.part1(input("day_21"))
  end

  def test_part2
    day = Day21.new

    assert_equal 444_356_092_776_315, day.part2(input("day_21_example_1"))
    assert_equal 27_674_034_218_179, day.part2(input("day_21"))
  end
end
