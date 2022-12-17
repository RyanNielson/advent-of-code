defmodule Day17Test do
  use ExUnit.Case

  import TestHelper
  import Day17

  test "part1" do
    assert part1(input("day_17_example_1")) == 3068
    assert part1(input("day_17")) == 3055
  end

  @tag timeout: :infinity
  test "part2" do
    # assert part2(input("day_17_example_1")) == 1_514_285_714_288
    # assert part2(input("day_17")) == 456
  end
end
