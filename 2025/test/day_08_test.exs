defmodule Day07Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day08.part_1(input("day_08_example_1"), 10) == 40
    assert Day08.part_1(input("day_08"), 1000) == 75680
  end

  test "part2" do
    assert Day08.part_2(input("day_08_example_1")) == 25272
    assert Day08.part_2(input("day_08")) == 8_995_844_880
  end
end
