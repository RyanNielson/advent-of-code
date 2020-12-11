defmodule Day11 do
  @adjacent_offsets [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]

  def part1(input) do
    input
    |> parse()
    |> count_occupied_seats()
  end

  # TODO: All the code involved in this part can be improved, but it works so...
  def part2(input) do
    grid =
      input
      |> parse()

    {min, max} = grid |> grid_min_max()

    grid
    |> count_occupied_seats_in_view(min, max)
  end

  defp grid_min_max(grid) do
    {min_x, max_x} =
      grid
      |> Map.keys()
      |> Enum.map(fn {x, _y} -> x end)
      |> Enum.min_max()

    {min_y, max_y} =
      grid
      |> Map.keys()
      |> Enum.map(fn {_x, y} -> y end)
      |> Enum.min_max()

    {{min_x, min_y}, {max_x, max_y}}
  end

  defp count_occupied_seats(grid) do
    new_grid =
      grid
      |> Enum.reduce(%{}, fn {position, value}, acc ->
        new_value =
          cond do
            empty_and_occupied_adjacent_seat?(grid, position, value) -> "#"
            occupied_and_adjacent_seats?(grid, position, value) -> "L"
            true -> value
          end

        Map.put(acc, position, new_value)
      end)

    cond do
      grid == new_grid -> new_grid |> Map.values() |> Enum.count(fn value -> value == "#" end)
      true -> count_occupied_seats(new_grid)
    end
  end

  defp count_occupied_seats_in_view(grid, min, max) do
    new_grid =
      grid
      |> Enum.reduce(%{}, fn {position, value}, acc ->
        new_value =
          cond do
            can_see_empty_and_occupied_seat?(grid, position, value, min, max) -> "#"
            can_see_occupied_and_seats?(grid, position, value, min, max) -> "L"
            true -> value
          end

        Map.put(acc, position, new_value)
      end)

    cond do
      grid == new_grid -> new_grid |> Map.values() |> Enum.count(fn value -> value == "#" end)
      true -> count_occupied_seats_in_view(new_grid, min, max)
    end
  end

  defp empty_and_occupied_adjacent_seat?(grid, {x, y}, "L") do
    @adjacent_offsets
    |> Enum.count(fn {x_offset, y_offset} ->
      Map.get(grid, {x + x_offset, y + y_offset}, ".") == "#"
    end) == 0
  end

  defp empty_and_occupied_adjacent_seat?(_grid, _position, _value), do: false

  defp occupied_and_adjacent_seats?(grid, {x, y}, "#") do
    @adjacent_offsets
    |> Enum.count(fn {x_offset, y_offset} ->
      Map.get(grid, {x + x_offset, y + y_offset}, ".") == "#"
    end) >= 4
  end

  defp occupied_and_adjacent_seats?(_grid, _position, _value), do: false

  defp view_positions(
         {x, y},
         {x_offset, y_offset},
         {min_x, min_y},
         {max_x, max_y},
         positions \\ []
       ) do
    {new_x, new_y} = {x + x_offset, y + y_offset}

    cond do
      new_x >= min_x && new_x <= max_x && new_y >= min_y && new_y <= max_y ->
        view_positions({new_x, new_y}, {x_offset, y_offset}, {min_x, min_y}, {max_x, max_y}, [
          {new_x, new_y} | positions
        ])

      true ->
        Enum.reverse(positions)
    end
  end

  defp can_see_empty_and_occupied_seat?(grid, {x, y}, "L", min, max) do
    @adjacent_offsets
    |> Enum.count(fn offset ->
      view_positions({x, y}, offset, min, max)
      |> Enum.reduce_while(false, fn pos, acc ->
        value = Map.get(grid, pos, ".")

        case value do
          "." -> {:cont, acc}
          "#" -> {:halt, true}
          "L" -> {:halt, false}
        end
      end)
    end) == 0
  end

  defp can_see_empty_and_occupied_seat?(_grid, _position, _value, _min, _max), do: false

  defp can_see_occupied_and_seats?(grid, {x, y}, "#", min, max) do
    @adjacent_offsets
    |> Enum.count(fn offset ->
      view_positions({x, y}, offset, min, max)
      |> Enum.reduce_while(false, fn pos, acc ->
        value = Map.get(grid, pos, ".")

        case value do
          "." -> {:cont, acc}
          "#" -> {:halt, true}
          "L" -> {:halt, false}
        end
      end)
    end) >= 5
  end

  defp can_see_occupied_and_seats?(_grid, _position, _value, _min, _max), do: false

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, y}, acc ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.into(%{}, fn {value, x} -> {{x, y}, value} end)
      |> Map.merge(acc)
    end)
  end
end
