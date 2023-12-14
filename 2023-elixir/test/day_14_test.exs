defmodule Day14Test do
  use ExUnit.Case

  import TestHelper
  import Day14

  test "part1" do
    assert part_1(input("day_14_example_1")) == 136
    assert part_1(input("day_14")) == 110_821
  end

  test "part2" do
    # assert part_2(input("day_11")) == 613_686_987_427
  end
end
