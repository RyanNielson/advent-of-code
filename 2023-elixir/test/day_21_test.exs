defmodule Day21Test do
  use ExUnit.Case

  import TestHelper
  import Day21

  test "part1" do
    assert part_1(input("day_21_example_1"), 6) == 16
    assert part_1(input("day_21"), 64) == 3709
  end

  test "part2" do
    # assert part_2(input("day_11")) == 613_686_987_427
  end
end
