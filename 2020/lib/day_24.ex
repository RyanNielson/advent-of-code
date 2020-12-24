defmodule Day24 do
  def part1(input) do
    input
    |> parse()
    |> tiles_to_flip()
    |> flip_tiles()
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse()
    |> tiles_to_flip()
    |> flip_tiles()
    |> simulate()
    |> Enum.count()
  end

  defp simulate(floor) do
    0..(100 - 1)
    |> Enum.reduce(floor, fn _, previous_floor ->
      previous_floor
      |> Enum.flat_map(&[&1 | neighbours(&1)])
      |> Enum.uniq()
      |> Enum.reduce(previous_floor, fn tile, new_floor ->
        black? = MapSet.member?(previous_floor, tile)

        num_black_neighbours =
          tile
          |> neighbours()
          |> Enum.count(&MapSet.member?(previous_floor, &1))

        cond do
          black? && (num_black_neighbours == 0 || num_black_neighbours > 2) ->
            MapSet.delete(new_floor, tile)

          !black? && num_black_neighbours == 2 ->
            MapSet.put(new_floor, tile)

          true ->
            new_floor
        end
      end)
    end)
  end

  defp neighbours({x, y, z}) do
    [
      {x + 1, y - 1, z},
      {x, y - 1, z + 1},
      {x - 1, y, z + 1},
      {x - 1, y + 1, z},
      {x, y + 1, z - 1},
      {x + 1, y, z - 1}
    ]
  end

  defp flip_tiles(tile_offsets) do
    tile_offsets
    |> Enum.reduce(MapSet.new(), fn tile, acc ->
      case MapSet.member?(acc, tile) do
        true ->
          MapSet.delete(acc, tile)

        false ->
          MapSet.put(acc, tile)
      end
    end)
  end

  defp tiles_to_flip(tiles) do
    tiles
    |> Enum.map(&flip(&1, {0, 0, 0}))
  end

  defp flip("", current_position) do
    current_position
  end

  defp flip("e" <> rest, {x, y, z}) do
    flip(rest, {x + 1, y - 1, z})
  end

  defp flip("se" <> rest, {x, y, z}) do
    flip(rest, {x, y - 1, z + 1})
  end

  defp flip("sw" <> rest, {x, y, z}) do
    flip(rest, {x - 1, y, z + 1})
  end

  defp flip("w" <> rest, {x, y, z}) do
    flip(rest, {x - 1, y + 1, z})
  end

  defp flip("nw" <> rest, {x, y, z}) do
    flip(rest, {x, y + 1, z - 1})
  end

  defp flip("ne" <> rest, {x, y, z}) do
    flip(rest, {x + 1, y, z - 1})
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
  end
end

# e, se, sw, w, nw, and ne
