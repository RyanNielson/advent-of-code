defmodule Day09Test do
  use ExUnit.Case

  import TestHelper
  # import Day09.part_1()

  test "part1" do
    assert Day09.part_1(input("day_09_example_1")) == 114
    assert Day09.part_1(input("day_09")) == 1_584_748_274
  end

  test "part2" do
    # assert part2(input("day_01_example_1")) == 45000
    # assert part2(input("day_01")) == 207_456
  end
end
