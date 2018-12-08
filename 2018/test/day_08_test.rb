require "test_helper"
require "day_08"

class Day08Test < Minitest::Test
  def setup
    @day_08 = Day08.new
  end

  # def test_part1
  #   assert_equal "CABDFE", @day_07.part1(sample_input_1)
  #   assert_equal "BCADPVTJFZNRWXHEKSQLUYGMIO", @day_07.part1(input("day_07.txt"))
  # end

  # def test_part2
  #   assert_equal 15, @day_07.part2(sample_input_1, 2, 0)
  #   assert_equal 973, @day_07.part2(input("day_07.txt"), 5, 60)
  # end

  # def test_letter_value
  #   assert_equal 1, @day_07.letter_value("A")
  #   assert_equal 2, @day_07.letter_value("B")
  #   assert_equal 3, @day_07.letter_value("C")
  #   assert_equal 26, @day_07.letter_value("Z")
  # end

  # def test_step_time
  #   assert_equal 1, @day_07.step_time("A", 0)
  #   assert_equal 26, @day_07.step_time("Z", 0)
  #   assert_equal 86, @day_07.step_time("Z", 60)
  # end

  # def test_related_steps
  #   assert_equal sample_input_1_steps_2, @day_07.related_steps(sample_input_1)
  # end

  def test_numbers
    assert_equal sample_input_1_numbers, @day_08.numbers(sample_input_1)
  end

  def sample_input_1
    "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"
  end

  def sample_input_1_numbers
    [2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2]
  end

  # def sample_input_1_steps
  #   {"A" => ["C"], "F" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["B", "D", "F"]}
  # end

  # def sample_input_1_steps_2
  #   {"C" => [], "A" => ["C"], "F" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["B", "D", "F"]}
  # end
end
