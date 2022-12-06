defmodule Day06 do
  def part1(input) do
    marker_position(input, 4)
  end

  def part2(input) do
    marker_position(input, 14)
  end

  defp marker_position(input, marker_length) do
    input
    |> String.graphemes()
    |> Enum.chunk_every(marker_length, 1)
    |> Enum.find_index(&(Enum.uniq(&1) == &1))
    |> Kernel.+(marker_length)
  end
end
