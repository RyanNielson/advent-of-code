defmodule Day21Test do
  use ExUnit.Case

  import TestHelper
  import Day21

  test "part1" do
    assert part1(input("day_21_example_1")) == 152
    assert part1(input("day_21")) == 309_248_622_142_100
  end

  test "part2" do
    # assert part2(input("day_21_example_1")) == 301
    # assert part2(input("day_21")) == 456
  end
end
