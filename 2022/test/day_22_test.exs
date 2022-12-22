defmodule Day22Test do
  use ExUnit.Case

  import TestHelper
  import Day22

  test "part1" do
    assert part1(input("day_22_example_1", false)) == 6032
    assert part1(input("day_22", false)) == 88268
  end

  test "part2" do
    # assert part2(input("day_22_example_1")) == 123
    # assert part2(input("day_22")) == 456
  end
end
