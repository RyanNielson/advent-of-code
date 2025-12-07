defmodule Day07Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day07.part_1(input("day_07_example_1")) == 21
    assert Day07.part_1(input("day_07")) == 1594
  end

  test "part2" do
    assert Day07.part_2(input("day_07_example_1")) == 40
    assert Day07.part_2(input("day_07")) == 15_650_261_281_478
  end
end
