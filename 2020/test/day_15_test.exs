defmodule Day15Test do
  use ExUnit.Case

  import Day15
  import TestHelper

  describe "Day15" do
    test "part1" do
      assert part1(input("day_15_example_1")) == 436
      assert part1(input("day_15_example_2")) == 1
      assert part1(input("day_15_example_3")) == 10
      assert part1(input("day_15_example_4")) == 27
      assert part1(input("day_15_example_5")) == 78
      assert part1(input("day_15_example_6")) == 438
      assert part1(input("day_15_example_7")) == 1836
      assert part1(input("day_15")) == 929
    end

    test "part2" do
      assert part2(input("day_15")) == 16_671_510
    end
  end
end
