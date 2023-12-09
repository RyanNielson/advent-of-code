defmodule Day09Test do
  use ExUnit.Case

  import TestHelper
  import Day09

  test "part1" do
    assert part_1(input("day_09_example_1")) == 114
    assert part_1(input("day_09")) == 1_584_748_274
  end

  test "part2" do
    assert part_2(input("day_09_example_1")) == 2
    assert part_2(input("day_09")) == 1026
  end
end
