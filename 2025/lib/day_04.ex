defmodule Day04 do
  def part_1(input) do
    grid =
      input
      |> String.split()
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, y} ->
        row
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.map(fn {character, x} -> {{x, y}, character} end)
      end)
      |> Enum.reject(fn {_, character} -> character == "." end)
      |> Enum.into(%{})

    grid
    |> Enum.count(fn {{x, y}, _} ->
      [
        {x - 1, y - 1},
        {x, y - 1},
        {x + 1, y - 1},
        {x - 1, y},
        {x + 1, y},
        {x - 1, y + 1},
        {x, y + 1},
        {x + 1, y + 1}
      ]
      |> Enum.count(fn position -> grid[position] == "@" end)
      |> Kernel.<(4)
    end)
  end

  def part_2(input) do
    input
  end
end
