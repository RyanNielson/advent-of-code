defmodule AdventOfCode2017.Day08Test do
  use ExUnit.Case

  import AdventOfCode2017.Day08
  import AdventOfCode2017.TestHelper

  test "part1" do
    assert part1(sample_input_1()) == 1
    assert part1(input("test/input/day_08.txt")) == 3612
  end

  test "part2" do
    assert part2(sample_input_1()) == 10
    assert part2(input("test/input/day_08.txt")) == 3818
  end

  test "parse" do
    assert parse(sample_input_1()) == sample_instructions_1()
  end

  test "init registers" do
    assert init_registers(sample_instructions_1()) == %{"b" => 0, "a" => 0, "c" => 0}
  end

  defp sample_input_1 do
    "b inc 5 if a > 1
    a inc 1 if b < 5
    c dec -10 if a >= 1
    c inc -20 if c == 10"
  end

  defp sample_instructions_1 do
    [
      ["b", "inc", 5, "a", ">", 1],
      ["a", "inc", 1, "b", "<", 5],
      ["c", "dec", -10, "a", ">=", 1],
      ["c", "inc", -20, "c", "==", 10]
    ]
  end
end