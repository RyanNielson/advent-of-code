defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  import AdventOfCode2019.TestHelper

  test "part1" do
    IO.puts(input("day_01.txt"))
    assert Day01.hello() == :world
  end
end
