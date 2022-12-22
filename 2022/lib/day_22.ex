defmodule Day22 do
  def part1(input) do
    {map, leftmost, path} =
      input
      |> parse()

    path
    |> Enum.reduce({leftmost, 0}, fn amount, me ->
      move(amount, me, map)
    end)
    |> then(fn {{x, y}, direction} -> 1000 * (y + 1) + 4 * (x + 1) + direction end)
  end

  defp move("L", {position, direction}, _) do
    {position, Integer.mod(direction - 1, 4)}
  end

  defp move("R", {position, direction}, _) do
    {position, Integer.mod(direction + 1, 4)}
  end

  defp move(amount, {position, direction}, map) do
    movement_offset =
      case direction do
        0 -> {1, 0}
        1 -> {0, 1}
        2 -> {-1, 0}
        3 -> {0, -1}
      end

    new_position =
      1..amount
      |> Enum.reduce_while(position, fn _, {x, y} ->
        {new_x, new_y} =
          new_position = {x + elem(movement_offset, 0), y + elem(movement_offset, 1)}

        row_positions = map |> Map.keys() |> Enum.filter(fn {_, y} -> y == new_y end)
        col_positions = map |> Map.keys() |> Enum.filter(fn {x, _} -> x == new_x end)

        {{min_x, _}, {max_x, _}} =
          Enum.min_max_by(row_positions, fn {x, _} -> x end, fn -> {{0, 0}, {0, 0}} end)

        {{_, min_y}, {_, max_y}} =
          Enum.min_max_by(col_positions, fn {_, y} -> y end, fn -> {{0, 0}, {0, 0}} end)

        # TODO: This can probably be done better with a combo of min(max())
        new_position =
          cond do
            direction == 0 && new_x > max_x -> {min_x, new_y}
            direction == 1 && new_y > max_y -> {new_x, min_y}
            direction == 2 && new_x < min_x -> {max_x, new_y}
            direction == 3 && new_y < min_y -> {new_x, max_y}
            true -> new_position
          end

        # IO.inspect(new_position)
        tile = Map.get(map, new_position)

        case tile do
          "." -> {:cont, new_position}
          "#" -> {:halt, {x, y}}
        end
      end)

    {new_position, direction}
  end

  def part2(input) do
    input
  end

  defp parse(input) do
    [map, path] = String.split(input, "\n\n")

    map =
      map
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.codepoints()
        |> Enum.with_index()
        |> Enum.reject(fn {tile, _} -> tile == " " end)
        |> Enum.map(fn {tile, x} -> {{x, y}, tile} end)
      end)
      |> Map.new()

    leftmost =
      map
      |> Map.keys()
      |> Enum.min_by(fn {x, y} -> {y, x} end)

    path =
      path
      |> String.trim()
      |> String.split(~r/(\d+|[LR])/, trim: true, include_captures: true)
      |> Enum.map(fn instruction ->
        case Integer.parse(instruction) do
          :error -> instruction
          {num, _} -> num
        end
      end)

    {map, leftmost, path}
  end
end
