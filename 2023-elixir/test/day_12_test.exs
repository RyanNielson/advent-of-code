defmodule Day12Test do
  use ExUnit.Case

  import TestHelper
  import Day12

  test "part1" do
    assert part_1(input("day_12_example_1")) == 21
    assert part_1(input("day_12")) == 7260
  end

  test "part2" do
    # assert part_2(input("day_11")) == 613_686_987_427
  end
end
