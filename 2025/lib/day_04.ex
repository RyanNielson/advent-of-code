defmodule Day04 do
  def part_1(input) do
    input |> build_grid |> accessible_rolls() |> Enum.count()
  end

  def part_2(input) do
    input |> build_grid() |> remove()
  end

  defp accessible_rolls(grid) do
    grid
    |> Map.keys()
    |> Enum.filter(fn {x, y} ->
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

  defp remove(grid, removed \\ []) do
    to_remove = accessible_rolls(grid)

    case to_remove do
      [] ->
        removed

      _ ->
        remove(Map.drop(grid, to_remove), to_remove ++ removed)
    end
  end

  defp build_grid(input) do
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
  end
end
