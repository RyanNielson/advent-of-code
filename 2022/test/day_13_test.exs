defmodule Day13Test do
  use ExUnit.Case

  import TestHelper
  import Day13

  test "part1" do
    assert part1(input("day_13_example_1")) == 13
    assert part1(input("day_13")) == 5555
  end

  test "part2" do
    assert part2(input("day_13_example_1")) == 140
    assert part2(input("day_13")) == 22852
  end
end
