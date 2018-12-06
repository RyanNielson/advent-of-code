defmodule AdventOfCode2018.Day05Test do
  use ExUnit.Case

  import AdventOfCode2018.Day05
  import AdventOfCode2018.TestHelper

  test "part1" do
    assert part1(input_sample()) == 10
    assert part1(input("day_05.txt")) == 11894
  end

  test "part2" do
    assert part2(input_sample()) == 4
    assert part2(input("day_05.txt")) == 5310
  end

  # test "part2" do
  #   assert part2(input_sample()) == 4
  #   # assert part2(input("day_05.txt")) == 24774780
  # end

  # test "remove reacting units" do
  #   assert remove_reacting_units(input_sample()) == "dabCBAcaDA"
  # end

  test "test_opposite_polarity?" do
    assert opposite_polarity?("a", "A")
    assert opposite_polarity?("A", "a")
    refute opposite_polarity?("a", "a")
    refute opposite_polarity?("A", "A")
    refute opposite_polarity?("a","B")
    refute opposite_polarity?("B", "a")
    refute opposite_polarity?("A", "B")
    refute opposite_polarity?("a", "b")
  end

  defp input_sample, do: "dabAcCaCBAcCcaDA"
end