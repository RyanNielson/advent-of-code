defmodule AdventOfCode2017.Day16Test do
  use ExUnit.Case

  import AdventOfCode2017.Day16
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1(sample_input_1(), "abcde") == "baedc"
    assert part1(input("test/input/day_16.txt")) == "pkgnhomelfdibjac"
  end

  test "spin" do
    assert spin(["a", "b", "c", "d", "e"], 3) == ["c", "d", "e", "a", "b"]
    assert spin(["a", "b", "c", "d", "e"], 1) == ["e", "a", "b", "c", "d"]
  end

  test "exchange" do
    assert exchange(["e", "a", "b", "c", "d"], 3, 4) == ["e", "a", "b", "d", "c"] 
  end

  test "partner" do
    assert partner(["e", "a", "b", "d", "c"], "e", "b") == ["b", "a", "e", "d", "c"] 
  end

  # test "part2" do
  #   assert part2(sample_input_1()) == 309
  #   assert part2(input("test/input/day_15.txt")) == 343
  # end

  test "parse" do
    assert parse(sample_input_1()) == [{"s", 1}, {"x", 3, 4}, {"p", "e", "b"}]
  end

  defp sample_input_1, do: "s1,x3/4,pe/b"
end