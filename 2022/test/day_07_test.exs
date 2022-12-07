defmodule Day07Test do
  use ExUnit.Case

  import TestHelper
  import Day07

  test "part1" do
    assert part1(input("day_07_example_1")) == 95437
    assert part1(input("day_07")) == 1_477_771
  end

  test "part2" do
    assert part2(input("day_07_example_1")) == 24_933_642
    assert part2(input("day_07")) == 3_579_501
  end
end
