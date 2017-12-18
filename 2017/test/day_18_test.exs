defmodule AdventOfCode2017.Day18Test do
  use ExUnit.Case

  import AdventOfCode2017.Day18
  import AdventOfCode2017.TestHelper

  # test "part1" do
  #   assert part1(sample_input_1()) == 4
  #   # assert part1(input("test/input/day_17.txt")) == 1173
  # end

  # test "snd" do

  # end

  test "set" do
    modified_registers = execute({"set", "a", 1}, sample_registers_1())
    assert modified_registers["a"] == 1
    # assert execute({"set", "a", 1}, sample_registers_1()) == 4
  end

  test "add" do
    modified_registers = execute({"add", "b", 3}, sample_registers_1())
    assert modified_registers["b"] == 3
  end

  test "mul" do
    registers = Map.put(sample_registers_1(), "c", 4)
    modified_registers = execute({"mul", "c", 2}, registers)
    assert modified_registers["c"] == 8
  end

  test "mod" do
    registers = Map.put(sample_registers_1(), "d", 5)
    modified_registers = execute({"mod", "d", 3}, registers)
    assert modified_registers["d"] == 2
  end

  # test "rcv" do

  # end

  # test "jgz" do

  # end

  # test "part2" do
  #   assert part2(input("test/input/day_17.txt")) == 1930815
  # end

  test "parse" do
    assert parse(sample_input_1()) == sample_instructions_1()
  end

  def sample_input_1() do
    "set a 1\nadd a 2\nmul a a\nmod a 5\nsnd a\nset a 0\nrcv a\njgz a -1\nset a 1\njgz a -2"
  end

  def sample_instructions_1() do
    [
      {"set", "a", 1},
      {"add", "a", 2},
      {"mul", "a", "a"},
      {"mod", "a", 5},
      {"snd", "a"},
      {"set", "a", 0},
      {"rcv", "a"},
      {"jgz", "a", -1},
      {"set", "a", 1},
      {"jgz", "a", -2}
    ]
  end

  def sample_registers_1() do
    Map.new(?a..?z, fn reg -> {<<reg :: utf8>>, 0} end)
  end
end