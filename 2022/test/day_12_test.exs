defmodule Day12Test do
  use ExUnit.Case

  import TestHelper
  import Day12

  @tag timeout: :infinity
  test "part1" do
    assert part1(input("day_12_example_1")) == 31
    assert part1(input("day_12")) == 517
  end

  test "part2" do
    assert part2(input("day_12_example_1")) == 29
    assert part2(input("day_12")) == 512
  end
end
