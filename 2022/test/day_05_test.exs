defmodule Day05Test do
  use ExUnit.Case

  import TestHelper
  import Day05

  test "part1" do
    assert part1(input("day_05_example_1", false)) == "CMZ"
    assert part1(input("day_05", false)) == "TWSGQHNHL"
  end

  test "part2" do
    assert part2(input("day_05_example_1", false)) == "MCD"
    assert part2(input("day_05", false)) == "JNRSCDWPP"
  end
end
