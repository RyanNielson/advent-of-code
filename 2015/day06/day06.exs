defmodule Day06 do
  def how_many_lights_are_lit?(path) do
    run_commands(path) |> Enum.count(fn({_, state}) -> state == :on end)
  end

  defp run_commands(path) do
    Enum.reduce(commands(path), make_grid(1000, 1000), fn(command, grid) ->
      case command do
        {:turn_on, s, e}  -> turn_on(generate_coordinates(s, e), grid)
        {:turn_off, s, e} -> turn_off(generate_coordinates(s, e), grid)
        {:toggle, s, e}   -> toggle(generate_coordinates(s, e), grid)
      end
    end)
  end

  defp commands(path), do: lines(path) |> Enum.map(&String.split/1) |> Enum.map(&format_command/1)

  defp generate_coordinates({x0, y0}, {x1, y1}) do
    for x <- x0..x1, y <- y0..y1, do: {x, y}
  end

  defp toggle(coords, grid) when is_list(coords), do: Enum.reduce(coords, grid, &toggle/2)
  defp toggle(coord, grid) do
    case Dict.get(grid, coord) do
      :on  -> turn_off(coord, grid)
      :off -> turn_on(coord, grid)
    end
  end

  defp turn_on(coords, grid) when is_list(coords), do: Enum.reduce(coords, grid, &turn_on/2)
  defp turn_on(coord, grid), do: Dict.put(grid, coord, :on)

  defp turn_off(coords, grid) when is_list(coords), do: Enum.reduce(coords, grid, &turn_off/2)
  defp turn_off(coord, grid), do: Dict.put(grid, coord, :off)

  defp make_grid(width, height, default \\ :off) do
    (for x <- 0..(width-1), y <- 0..(height-1), do: {x, y})
    |> Enum.reduce(%{}, fn(key, a) -> Dict.put(a, key, default) end)
  end

  defp format_command([_, "on", c, _, d]),  do: to_command(:turn_on, c, d)
  defp format_command([_, "off", c, _, d]), do: to_command(:turn_off, c, d)
  defp format_command(["toggle", c, _, d]), do: to_command(:toggle, c, d)

  defp to_command(type, c, d) do
   [x, y]   = String.split(c, ",") |> Enum.map(&String.to_integer/1)
   [xx, yy] = String.split(d, ",") |> Enum.map(&String.to_integer/1)
   {type, {x, y}, {xx, yy}}
 end

  defp lines(path), do: path |> File.read! |> String.split("\n", trim: true)
end


IO.puts "Part 1: " <> to_string(Day06.how_many_lights_are_lit?("day06.input"))
