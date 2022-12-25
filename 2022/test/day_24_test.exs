defmodule Day24Test do
  use ExUnit.Case

  import TestHelper
  import Day24

  @tag timeout: :infinity
  test "part1" do
    assert part1(input("day_24_example_1")) == 18
    assert part1(input("day_24")) == 221
  end

  test "part2" do
    assert part2(input("day_24_example_1")) == 54
    assert part2(input("day_24")) == 739
  end
end
