defmodule Day14Test do
  use ExUnit.Case

  import TestHelper
  import Day14

  test "part1" do
    assert part1(input("day_14_example_1")) == 24
    assert part1(input("day_14")) == 644
  end

  test "part2" do
    # assert part2(input("day_14_example_1")) == 123
    # assert part2(input("day_14")) == 456
  end
end
