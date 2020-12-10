defmodule Day10Test do
  use ExUnit.Case

  import Day10
  import TestHelper

  describe "Day10" do
    test "part1" do
      assert part1(input("day_10_example_1")) == 35
      assert part1(input("day_10_example_2")) == 220
      assert part1(input("day_10")) == 2346
    end

    test "part2" do
      assert part2(input("day_10_example_1")) == 8
      assert part2(input("day_10_example_2")) == 19208
      assert part2(input("day_10")) == 6_044_831_973_376
    end
  end
end
