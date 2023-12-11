defmodule Day11Test do
  use ExUnit.Case

  import TestHelper
  import Day11

  test "part1" do
    assert part_1(input("day_11_example_1")) == 374
    assert part_1(input("day_11")) == 9_214_785
  end

  test "part2" do
    assert part_2(input("day_11")) == 613_686_987_427
  end
end
