defmodule Day05Test do
  use ExUnit.Case

  import TestHelper

  test "part1" do
    assert Day05.part_1(input("day_05_example_1")) == 3
    assert Day05.part_1(input("day_05")) == 735
  end

  test "part2" do
    assert Day05.part_2(input("day_05_example_1")) == 14
    assert Day05.part_2(input("day_05")) == 344_306_344_403_172
  end
end
