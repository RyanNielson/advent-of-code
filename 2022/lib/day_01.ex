defmodule Day01 do
  def part1(input) do
    input
    |> elf_calories()
    |> Enum.max()
  end

  def part2(input) do
    input
    |> elf_calories()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp elf_calories(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn elf ->
      elf
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
  end
end
