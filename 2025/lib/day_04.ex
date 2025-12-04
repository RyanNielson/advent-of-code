defmodule Day04 do
  def part_1(input) do
    solve(input, &accessible_rolls/1)
  end

  def part_2(input) do
    solve(input, &remove/1)
  end

  defp solve(input, work_fun) do
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
    |> work_fun.()
    |> Enum.count()
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
end
