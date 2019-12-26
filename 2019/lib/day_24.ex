defmodule Day24 do
  @doc """
  ## Examples
    iex> Helpers.input("day_24_example_1") |> Day24.part1()
    2_129_920

    iex> Helpers.input("day_24") |> Day24.part1()
    18_350_099
  """
  def part1(input) do
    input
    |> parse()
    |> run()
    |> biodiversity_rating()
  end

  defp run(grid, old_grids \\ MapSet.new()) do
    new_grid = step(grid)

    case MapSet.member?(old_grids, new_grid) do
      true -> new_grid
      false -> run(new_grid, MapSet.put(old_grids, new_grid))
    end
  end

  defp biodiversity_rating(grid) do
    grid
    |> Enum.map(fn {{x, y}, value} ->
      case value do
        "." -> 0
        "#" -> :math.pow(2, x + y * 5) |> round()
      end
    end)
    |> Enum.sum()
  end

  def step(grid) do
    grid
    |> Enum.reduce(%{}, fn {position, value}, new_grid ->
      Map.put(new_grid, position, act(position, value, grid))
    end)
  end

  def act(position, value, grid) do
    count = adjacent_bugs_count(position, grid)

    cond do
      value == "#" and count != 1 -> "."
      value == "." and (count == 1 or count == 2) -> "#"
      true -> value
    end
  end

  def adjacent_bugs_count({x, y}, grid) do
    left = Map.get(grid, {x - 1, y}, ".")
    up = Map.get(grid, {x, y - 1}, ".")
    right = Map.get(grid, {x + 1, y}, ".")
    down = Map.get(grid, {x, y + 1}, ".")

    [left, up, right, down]
    |> Enum.count(fn x -> x == "#" end)
  end

  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {value, x} ->
        {{x, y}, value}
      end)
    end)
    |> Enum.into(%{})
  end
end
