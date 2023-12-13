defmodule Day13Test do
  use ExUnit.Case

  import TestHelper
  import Day13

  test "part1" do
    assert part_1(input("day_13_example_1")) == 405
    assert part_1(input("day_13")) == 35538
  end

  test "part2" do
    # assert part_2(input("day_11")) == 613_686_987_427
  end
end
