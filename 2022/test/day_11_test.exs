defmodule Day11Test do
  use ExUnit.Case

  import TestHelper
  import Day11

  test "part1" do
    assert part1(input("day_11_example_1")) == 10605
    assert part1(input("day_11")) == 120_056
  end

  @tag timeout: :infinity
  test "part2" do
    assert part2(input("day_11_example_1")) == 2_713_310_158
    assert part2(input("day_11")) == 21_816_744_824
  end
end
