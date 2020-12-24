defmodule Day24Test do
  use ExUnit.Case

  import Day24
  import TestHelper

  describe "Day24" do
    test "part1" do
      assert part1(input("day_24_example_1")) == 10
      assert part1(input("day_24")) == 360
    end

    test "part2" do
      assert part2(input("day_24_example_1")) == 2208
      assert part2(input("day_24")) == 3924
    end
  end
end
