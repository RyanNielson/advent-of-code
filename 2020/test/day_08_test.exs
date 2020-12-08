defmodule Day08Test do
  use ExUnit.Case

  import Day08
  import TestHelper

  describe "Day08" do
    test "part1" do
      assert part1(input("day_08_example_1")) == 5
      assert part1(input("day_08")) == 1749
    end

    test "part2" do
      assert part2(input("day_08_example_1")) == 8
      assert part2(input("day_08")) == 515
    end
  end
end
