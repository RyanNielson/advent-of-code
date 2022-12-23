defmodule Day23Test do
  use ExUnit.Case

  import TestHelper
  import Day23

  test "part1" do
    assert part1(input("day_23_example_1")) == 110
    assert part1(input("day_23")) == 3970
  end

  test "part2" do
    # assert part2(input("day_23_example_1")) == 123
    # assert part2(input("day_23")) == 456
  end
end
