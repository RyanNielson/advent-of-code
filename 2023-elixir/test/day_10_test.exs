defmodule Day10Test do
  use ExUnit.Case

  import TestHelper
  import Day10

  test "part1" do
    assert part_1(input("day_10_example_1")) == 4
    assert part_1(input("day_10_example_2")) == 8
    assert part_1(input("day_10")) == 7012
  end

  test "part2" do
    # assert part_2(input("day_09_example_1")) == 2
    # assert part_2(input("day_09")) == 1026
  end
end
