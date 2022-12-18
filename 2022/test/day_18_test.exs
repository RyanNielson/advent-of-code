defmodule Day18Test do
  use ExUnit.Case

  import TestHelper
  import Day18

  test "part1" do
    assert part1(input("day_18_example_1")) == 10
    assert part1(input("day_18_example_2")) == 64
    assert part1(input("day_18")) == 3542
  end

  test "part2" do
    assert part2(input("day_18_example_2")) == 58
    assert part2(input("day_18")) == 2080
  end
end
