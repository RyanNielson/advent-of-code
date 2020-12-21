defmodule Day20Test do
  use ExUnit.Case

  import Day20
  import TestHelper

  describe "Day20" do
    test "part1" do
      assert part1(input("day_20_example_1")) == 5
      assert part1(input("day_20")) == 2436
    end

    test "part2" do
      assert part2(input("day_20_example_1")) == "mxmxvkd,sqjhc,fvjkl"
      assert part2(input("day_20")) == "dhfng,pgblcd,xhkdc,ghlzj,dstct,nqbnmzx,ntggc,znrzgs"
    end
  end
end
