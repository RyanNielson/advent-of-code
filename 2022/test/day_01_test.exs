defmodule Day01Test do
  use ExUnit.Case
  # doctest Day01

  import TestHelper
  import Day01

  test "part1" do
    assert part1(input("day_01_example_1")) == 514_579
    assert part1(input("day_01")) == 73371
  end

  # test "greets the world" do
  #   assert true == false
  #   # assert AdventOfCode2020.hello() == :world
  # end
end
