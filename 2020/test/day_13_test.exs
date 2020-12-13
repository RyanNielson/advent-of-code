defmodule Day13Test do
  use ExUnit.Case

  import Day13
  import TestHelper

  describe "Day13" do
    test "part1" do
      assert part1(input("day_13_example_1")) == 295
      assert part1(input("day_13")) == 3269
    end

    # test "part2" do
    #   assert part2(input("day_12_example_1")) == 286
    #   assert part2(input("day_12")) == 126_797
    # end
  end
end
