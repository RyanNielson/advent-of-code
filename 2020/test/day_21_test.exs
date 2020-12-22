defmodule Day21Test do
  use ExUnit.Case

  import Day21
  import TestHelper

  describe "Day21" do
    test "part1" do
      assert part1(input("day_21_example_1")) == 5
      assert part1(input("day_21")) == 2436
    end

    test "part2" do
      assert part2(input("day_21_example_1")) == "mxmxvkd,sqjhc,fvjkl"
      assert part2(input("day_21")) == "dhfng,pgblcd,xhkdc,ghlzj,dstct,nqbnmzx,ntggc,znrzgs"
    end
  end
end
