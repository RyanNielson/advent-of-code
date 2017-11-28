defmodule Day03 do
  def run(path), do: visited_positions(directions(path)) |> Enum.uniq |> Enum.count

  def visited_positions(directions) do
    { visited_positions, _ } = Enum.map_reduce(directions, {0, 0}, fn(direction, position) ->
      new_position = move(position, direction)
      {new_position, new_position}
    end)

    [{0, 0} | visited_positions]
  end

  defp directions(path), do: String.split(File.read!(path), ~r//)

  defp move(position, "^"), do: change_position_y(position, 1)
  defp move(position, "v"), do: change_position_y(position, -1)
  defp move(position, ">"), do: change_position_x(position, 1)
  defp move(position, "<"), do: change_position_x(position, -1)
  defp move(position, _), do: position

  defp change_position_x(position, amount), do: put_elem(position, 0, elem(position, 0) + amount)
  defp change_position_y(position, amount), do: put_elem(position, 1, elem(position, 1) + amount)
end

IO.puts Day03.run("day03.input")
