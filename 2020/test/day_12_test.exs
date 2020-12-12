defmodule Day12Test do
  use ExUnit.Case

  import Day12
  import TestHelper

  describe "Day12" do
    test "part1" do
      assert part1(input("day_12_example_1")) == 25
      assert part1(input("day_12")) == 1956
    end

    test "part2" do
      assert part2(input("day_12_example_1")) == 286
      assert part2(input("day_12")) == 126_797
    end
  end
end
