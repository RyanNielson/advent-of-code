defmodule Day09 do
  def part1(input) do
    input
    |> positions([{0, 0}, {0, 0}])
  end

  def part2(input) do
    input
    |> positions([{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}])
  end

  defp positions(steps_input, starting_knots) do
    steps_input
    |> parse()
    |> Enum.map_reduce(starting_knots, fn step, knots ->
      knots = move_knots(knots, step)
      {List.last(knots), knots}
    end)
    |> elem(0)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp move_knots([first | []], step), do: [move(first, step)]

  defp move_knots([first, second | rest], step) do
    first = move(first, step)

    case touching?(first, second) do
      true -> [first, second | rest]
      false -> [first | move_knots([second | rest], determine_step(first, second))]
    end
  end

  defp move({x, y}, {sx, sy}), do: {x + sx, y + sy}

  defp determine_step({x1, y1} = first, {x2, y2}) do
    case x2 == x1 || y2 == y1 do
      true -> [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]
      false -> [{1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
    end
    |> Enum.find(fn {sx, sy} -> touching?(first, {x2 + sx, y2 + sy}) end)
  end

  defp touching?(first, {x, y}) do
    [
      {x, y},
      {x + 1, y},
      {x - 1, y},
      {x, y + 1},
      {x, y - 1},
      {x + 1, y + 1},
      {x + 1, y - 1},
      {x - 1, y + 1},
      {x - 1, y - 1}
    ]
    |> Enum.any?(&Kernel.==(&1, first))
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.flat_map(fn <<direction::binary-size(1), " ", amount::binary>> ->
      motion_to_steps(direction, String.to_integer(amount))
    end)
  end

  defp motion_to_steps("R", amount), do: for(_ <- 0..(amount - 1), do: {1, 0})
  defp motion_to_steps("L", amount), do: for(_ <- 0..(amount - 1), do: {-1, 0})
  defp motion_to_steps("U", amount), do: for(_ <- 0..(amount - 1), do: {0, 1})
  defp motion_to_steps("D", amount), do: for(_ <- 0..(amount - 1), do: {0, -1})
end
