defmodule Day02Test do
  use ExUnit.Case

  import TestHelper
  import Day02

  test "part1" do
    assert part1(input("day_02_example_1")) == 15
    assert part1(input("day_02")) == 11449
  end

  test "part2" do
    assert part2(input("day_02_example_1")) == 12
    assert part2(input("day_02")) == 13187
  end
end
