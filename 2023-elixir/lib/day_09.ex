defmodule Day09 do
  def part_1(input) do
    input
    |> histories()
    |> Enum.map(&next_sequence/1)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> histories()
    |> Enum.map(fn sequence -> sequence |> Enum.reverse() |> next_sequence() end)
    |> Enum.sum()
  end

  defp histories(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> String.split() |> Enum.map(&String.to_integer/1)
    end)
  end

  defp next_sequence(sequence) do
    if Enum.all?(sequence, &(&1 == 0)) do
      0
    else
      (sequence
       |> Enum.chunk_every(2, 1, :discard)
       |> Enum.map(fn [l, r] -> r - l end)
       |> next_sequence()) + List.last(sequence)
    end
  end
end
