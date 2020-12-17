defmodule Day17 do
  def part1(input) do
    input
    |> parse()
    |> solve(&neighbours/1)
  end

  def part2(input) do
    input
    |> parse(true)
    |> solve(&neighbours_4d/1)
  end

  defp solve(grid, neighbour_fn) do
    0..(6 - 1)
    |> Enum.reduce(grid, fn _, previous_grid ->
      previous_grid
      |> Enum.flat_map(&[&1 | neighbour_fn.(&1)])
      |> Enum.uniq()
      |> Enum.reduce(MapSet.new(), fn point, new_grid ->
        active? = MapSet.member?(previous_grid, point)

        num_active_neighbours =
          point
          |> neighbour_fn.()
          |> Enum.count(&MapSet.member?(previous_grid, &1))

        cond do
          active? && (num_active_neighbours == 2 || num_active_neighbours == 3) ->
            MapSet.put(new_grid, point)

          !active? && num_active_neighbours == 3 ->
            MapSet.put(new_grid, point)

          true ->
            new_grid
        end
      end)
    end)
    |> Enum.count()
  end

  defp neighbours({x, y, z}) do
    for x_offset <- -1..1,
        y_offset <- -1..1,
        z_offset <- -1..1,
        !(x_offset == 0 && y_offset == 0 && z_offset == 0),
        do: {x + x_offset, y + y_offset, z + z_offset}
  end

  defp neighbours_4d({x, y, z, w}) do
    for x_offset <- -1..1,
        y_offset <- -1..1,
        z_offset <- -1..1,
        w_offset <- -1..1,
        !(x_offset == 0 && y_offset == 0 && z_offset == 0 && w_offset == 0),
        do: {x + x_offset, y + y_offset, z + z_offset, w + w_offset}
  end

  defp parse(input, four_d? \\ false) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {str, y} ->
      str
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {value, x} -> {value, x, y} end)
    end)
    |> Enum.reduce(MapSet.new(), fn
      {"#", x, y}, acc -> MapSet.put(acc, if(four_d?, do: {x, y, 0, 0}, else: {x, y, 0}))
      _, acc -> acc
    end)
  end
end
