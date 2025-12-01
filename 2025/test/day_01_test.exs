defmodule Day01Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day01.part_1(input("day_01_example_1")) == 3
    assert Day01.part_1(input("day_01")) == 1139
  end

  test "part2" do
    assert Day01.part_2(input("day_01_example_1")) == 6
    assert Day01.part_2(input("day_01")) == 6684
  end
end
