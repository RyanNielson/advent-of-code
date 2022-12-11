defmodule Day11Test do
  use ExUnit.Case

  import TestHelper
  import Day11

  test "part1" do
    assert part1(input("day_11_example_1")) == 10605
    assert part1(input("day_11")) == 120_056
  end

  test "part2" do
    # assert part2(input("day_11_example_1")) == 123
    # assert part2(input("day_11")) == 456
  end
end
