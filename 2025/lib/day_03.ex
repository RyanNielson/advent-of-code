defmodule Day03 do
  def part_1(input) do
    input
    |> solve(2)
  end

  def part_2(input) do
    input
    |> solve(12)
  end

  defp solve(input, length) do
    input
    |> String.split()
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&highest_joltage(&1, length))
    |> Enum.sum()
  end

  defp highest_joltage(bank, i, acc \\ [])

  defp highest_joltage(_bank, 0, acc) do
    acc |> Enum.reverse() |> Enum.join() |> String.to_integer()
  end

  defp highest_joltage(bank, i, acc) do
    limit = length(bank) - (i - 1)

    {best_battery, best_index} =
      bank
      |> Enum.take(limit)
      |> Enum.with_index()
      |> Enum.max_by(&elem(&1, 0))

    remaining = bank |> Enum.drop(best_index + 1)

    highest_joltage(remaining, i - 1, [best_battery | acc])
  end
end
