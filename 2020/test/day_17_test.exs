defmodule Day17Test do
  use ExUnit.Case

  import Day17
  import TestHelper

  describe "Day17" do
    test "part1" do
      assert part1(input("day_17_example_1")) == 112
      assert part1(input("day_17")) == 247
    end

    test "part2" do
      assert part2(input("day_17_example_1")) == 848
      assert part2(input("day_17")) == 1392
    end
  end
end
