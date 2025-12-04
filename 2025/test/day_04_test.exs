defmodule Day04Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day04.part_1(input("day_04_example_1")) == 13
    assert Day04.part_1(input("day_04")) == 1551
  end

  test "part2" do
    assert Day04.part_2(input("day_04_example_1")) == 43
    assert Day04.part_2(input("day_04")) == 9784
  end
end
