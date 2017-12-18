defmodule AdventOfCode2017.Day18 do
  def part1(input) do
    build_registers()
  end


  def execute({"snd", reg}, registers) do

  end

  def execute({"set", reg, val}, registers) do
    Map.put(registers, reg, val)
  end

  def execute({"add", reg, val}, registers) do
    Map.update(registers, reg, 0, &(&1 + val))
  end

  def execute({"mul", reg, val}, registers) do
    Map.update(registers, reg, 0, &(&1 * val))
  end

  def execute({"mod", reg, val}, registers) do
    Map.update(registers, reg, 0, &(rem(&1, val)))
  end

  def execute({"rcv", reg}, registers) do

  end

  def execute({"jgz", reg, val}, registers) do

  end

  defp build_registers, do: Map.new(?a..?z, fn reg -> {<<reg :: utf8>>, 0} end)

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  def parse_instruction(instruction) do
    instruction
    |> String.split(" ", trim: true)
    |> Enum.map(fn item ->
      if Regex.match?(~r/\d+/, item), do: String.to_integer(item), else: item
    end)
    |> List.to_tuple()
  end
 end