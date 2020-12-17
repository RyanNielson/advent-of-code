defmodule Day17 do
  def part1(input) do
    input
    |> parse()
    |> solve()
    |> Enum.count()
  end

  # TODO: Clean this up
  defp solve(grid) do
    0..(6 - 1)
    |> Enum.reduce(grid, fn _, previous_grid ->
      points_to_consider =
        previous_grid
        |> Enum.flat_map(fn point ->
          [point | neighbours(point)]
        end)
        |> Enum.uniq()

      points_to_consider
      |> Enum.reduce(MapSet.new(), fn point, new_grid ->
        active? = MapSet.member?(previous_grid, point)
        neighbours = neighbours(point)

        active_neighbours =
          Enum.count(neighbours, fn neighbour -> MapSet.member?(previous_grid, neighbour) end)

        new_active? =
          case active? do
            true ->
              if active_neighbours == 2 || active_neighbours == 3, do: true, else: false

            false ->
              if active_neighbours == 3, do: true, else: false
          end

        case new_active? do
          true -> MapSet.put(new_grid, point)
          false -> new_grid
        end
      end)
    end)
  end

  defp neighbours({x, y, z}) do
    for x_offset <- -1..1,
        y_offset <- -1..1,
        z_offset <- -1..1,
        !(x_offset == 0 && y_offset == 0 && z_offset == 0),
        do: {x + x_offset, y + y_offset, z + z_offset}
  end

  # If a cube is active and exactly 2 or 3 of its neighbors are also active,
  # the cube remains active. Otherwise, the cube becomes inactive.
  # If a cube is inactive but exactly 3 of its neighbors are active, the cube
  # becomes active. Otherwise, the cube remains inactive.
  defp parse(input) do
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
      {"#", x, y}, acc -> MapSet.put(acc, {x, y, 0})
      _, acc -> acc
    end)
  end
end
