defmodule Day02Test do
  use ExUnit.Case

  import Day02
  import TestHelper

  describe "Day02" do
    test "part1" do
      assert part1(input("day_02_example_1")) == 2
      assert part1(input("day_02")) == 378
    end

    test "part2" do
      assert part2(input("day_02_example_1")) == 1
      assert part2(input("day_02")) == 280
    end
  end
end
