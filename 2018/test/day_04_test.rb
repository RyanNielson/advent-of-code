require "test_helper"
require "day_04"

class Day04Test < Minitest::Test
  def setup
    @day_04 = Day04.new
  end

  def test_part1
    assert_equal 240, @day_04.part1(sample_input_1)
    assert_equal 140932, @day_04.part1(input("day_04.txt"))
  end

  def test_part2
    assert_equal 4455, @day_04.part2(sample_input_1)
    assert_equal 51232, @day_04.part2(input("day_04.txt"))
  end

  def test_split_input
    assert_equal sample_input_2_sorted, @day_04.split_input(sample_input_2)
  end

  def sample_input_1
    "[1518-11-01 00:00] Guard #10 begins shift
    [1518-11-01 00:05] falls asleep
    [1518-11-01 00:25] wakes up
    [1518-11-01 00:30] falls asleep
    [1518-11-01 00:55] wakes up
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-02 00:40] falls asleep
    [1518-11-02 00:50] wakes up
    [1518-11-03 00:05] Guard #10 begins shift
    [1518-11-03 00:24] falls asleep
    [1518-11-03 00:29] wakes up
    [1518-11-04 00:02] Guard #99 begins shift
    [1518-11-04 00:36] falls asleep
    [1518-11-04 00:46] wakes up
    [1518-11-05 00:03] Guard #99 begins shift
    [1518-11-05 00:45] falls asleep
    [1518-11-05 00:55] wakes up"
  end

  def sample_input_2
    "[1518-11-01 00:05] falls asleep
    [1518-11-01 00:30] falls asleep
    [1518-11-01 00:00] Guard #10 begins shift
    [1518-11-01 00:25] wakes up
    [1518-11-01 23:58] Guard #99 begins shift
    [1518-11-01 00:55] wakes up
    [1518-11-02 00:50] wakes up
    [1518-11-02 00:40] falls asleep"
  end

  def sample_input_2_sorted
    ["[1518-11-01 00:00] Guard #10 begins shift",
    "[1518-11-01 00:05] falls asleep",
    "[1518-11-01 00:25] wakes up",
    "[1518-11-01 00:30] falls asleep",
    "[1518-11-01 00:55] wakes up",
    "[1518-11-01 23:58] Guard #99 begins shift",
    "[1518-11-02 00:40] falls asleep",
    "[1518-11-02 00:50] wakes up"]
  end
end
