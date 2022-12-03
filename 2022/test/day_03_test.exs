defmodule Day03Test do
  use ExUnit.Case

  import TestHelper
  import Day03

  test "part1" do
    assert part1(input("day_03_example_1")) == 157
    assert part1(input("day_03")) == 7878
  end

  test "part2" do
    assert part2(input("day_03_example_1")) == 70
    assert part2(input("day_03")) == 2760
  end
end
