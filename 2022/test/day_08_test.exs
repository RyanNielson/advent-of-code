defmodule Day08Test do
  use ExUnit.Case

  import TestHelper
  import Day08

  test "part1" do
    assert part1(input("day_08_example_1")) == 21
    assert part1(input("day_08")) == 1669
  end

  test "part2" do
    assert part2(input("day_08_example_1")) == 8
    assert part2(input("day_08")) == 331_344
  end
end
