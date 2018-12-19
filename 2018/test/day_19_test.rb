require "test_helper"
require "day_19"

class Day19Test < Minitest::Test
  def setup
    @day_19 = Day19.new
  end

  def test_part1
    assert_equal 7, @day_19.part1(sample_input_1)
    assert_equal 1482, @day_19.part1(input("day_19.txt"))
  end

  def test_part2
    assert_equal 1, @day_19.part2(input("day_19.txt"))
  end

  def test_parse
    ip, instructions = @day_19.parse(sample_input_1)
    ip2, _ = @day_19.parse(input("day_19.txt"))
    assert_equal 0, ip
    assert_equal 2, ip2
    assert_equal sample_input_1_instructions, instructions
  end

  def sample_input_1
    "#ip 0
    seti 5 0 1
    seti 6 0 2
    addi 0 1 0
    addr 1 2 3
    setr 1 0 0
    seti 8 0 4
    seti 9 0 5"
  end

  def sample_input_1_instructions
    [
      ["seti", 5, 0, 1],
      ["seti", 6, 0, 2],
      ["addi", 0, 1, 0],
      ["addr", 1, 2, 3],
      ["setr", 1, 0, 0],
      ["seti", 8, 0, 4],
      ["seti", 9, 0, 5]
    ]
  end
end
