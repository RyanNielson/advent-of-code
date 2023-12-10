defmodule Day10 do
  def part_1(input) do
    {pipes, start} =
      input
      |> parse()

    pipes |> loop_length(start, start) |> div(2)
  end

  def loop_length(pipes, position = {x, y}, previous_position, distance \\ 0) do
    current_pipe = Map.get(pipes, position)

    next_position =
      [{x + 1, y}, {x - 1, y}, {x, y - 1}, {x, y + 1}]
      |> Enum.filter(fn next_position ->
        # Make sure we're not trying to move to the last spot or where a pipe doesn't exist.
        next_position != previous_position && Map.get(pipes, next_position) != nil
      end)
      |> Enum.filter(fn next_position = {nx, ny} ->
        next_pipe = Map.get(pipes, next_position)

        cond do
          # RIGHT
          nx > x &&
              (current_pipe == "S" || current_pipe == "-" || current_pipe == "L" ||
                 current_pipe == "F") ->
            next_pipe == "-" || next_pipe == "J" || next_pipe == "7"

          # LEFT
          nx < x &&
              (current_pipe == "S" || current_pipe == "-" || current_pipe == "J" ||
                 current_pipe == "7") ->
            next_pipe == "-" || next_pipe == "L" || next_pipe == "F"

          # UP
          ny < y &&
              (current_pipe == "S" || current_pipe == "|" || current_pipe == "L" ||
                 current_pipe == "J") ->
            next_pipe == "|" || next_pipe == "7" || next_pipe == "F"

          # DOWN
          ny > y &&
              (current_pipe == "S" || current_pipe == "|" || current_pipe == "7" ||
                 current_pipe == "F") ->
            next_pipe == "|" || next_pipe == "L" || next_pipe == "J"

          true ->
            nil
        end
      end)
      |> List.first()

    if next_position == nil do
      distance + 1
    else
      loop_length(pipes, next_position, position, distance + 1)
    end
  end

  defp parse(input) do
    pipes =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, pipes ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(pipes, fn {char, x}, pipes ->
          if char != "." do
            Map.put(pipes, {x, y}, char)
          else
            pipes
          end
        end)
      end)

    {sx, sy} = start = pipes |> Enum.find(fn {position, value} -> value == "S" end) |> elem(0)

    {pipes, start}
  end

  def part_2(input) do
    input
  end
end
