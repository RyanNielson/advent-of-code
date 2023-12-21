defmodule Grid do
  defstruct [:cells, :width, :height]

  def new(cells) do
    cells = Map.new(cells)

    {x, _} = cells |> Map.keys() |> Enum.max_by(fn {x, _} -> x end)
    {_, y} = cells |> Map.keys() |> Enum.max_by(fn {_, y} -> y end)

    %Grid{cells: cells, width: x + 1, height: y + 1}
  end

  def contains?(grid, {x, y}) do
    x >= 0 && x < grid.width && y >= 0 && y < grid.height
  end

  def free?(grid, position) do
    Map.get(grid.cells, position) != "#"
  end
end

defmodule Day21 do
  def neighbours({x, y}, grid) do
    [{x, y - 1}, {x, y + 1}, {x + 1, y}, {x - 1, y}]
    |> Enum.filter(fn position ->
      Grid.contains?(grid, position) && Grid.free?(grid, position)
    end)
  end

  def part_1(input, steps) do
    grid = input |> parse()
    start = grid.cells |> Enum.find(fn {_, v} -> v == "S" end) |> elem(0)

    0..(steps - 1)
    |> Enum.reduce(MapSet.new([start]), fn _, positions ->
      positions
      |> Enum.reduce(MapSet.new(), fn position, new_positions ->
        position |> neighbours(grid) |> MapSet.new() |> MapSet.union(new_positions)
      end)
    end)
    |> Enum.count()
  end

  def part_2(input) do
    input
    |> parse()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, x} ->
        {{x, y}, char}
      end)
    end)
    |> Grid.new()
  end
end
