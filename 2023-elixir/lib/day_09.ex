defmodule Day09 do
  def part_1(input) do
    histories =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line |> String.split() |> Enum.map(&String.to_integer/1)
      end)

    histories
    |> Enum.map(&next_sequence/1)
    |> Enum.sum()
  end

  def next_sequence(sequence) do
    if Enum.all?(sequence, &(&1 == 0)) do
      0
    else
      List.last(sequence) +
        (sequence
         |> Enum.chunk_every(2, 1, :discard)
         |> Enum.map(fn [l, r] -> r - l end)
         |> next_sequence())
    end
  end
end
