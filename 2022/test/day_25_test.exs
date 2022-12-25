defmodule Day25Test do
  use ExUnit.Case

  import TestHelper
  import Day25

  test "part1" do
    assert part1(input("day_25_example_1")) == "2=-1=0"
    assert part1(input("day_25")) == "121=2=1==0=10=2-20=2"
  end

  test "part2" do
    # assert part2(input("day_25_example_1")) == 123
    # assert part2(input("day_25")) == 456
  end
end
