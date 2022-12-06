defmodule Day06Test do
  use ExUnit.Case

  import TestHelper
  import Day06

  test "part1" do
    assert part1(input("day_06_example_1")) == 7
    assert part1(input("day_06_example_2")) == 10
    assert part1(input("day_06")) == 1275
  end

  test "part2" do
    assert part2(input("day_06_example_1")) == 19
    assert part2(input("day_06_example_2")) == 29
    assert part2(input("day_06")) == 3605
  end
end
