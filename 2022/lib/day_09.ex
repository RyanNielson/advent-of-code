defmodule Day09 do
  def part1(input) do
    input
    |> parse()
    |> Enum.map_reduce({{0, 0}, {0, 0}}, fn step, {head, tail} ->
      do_moves(step, head, tail)
    end)
    |> elem(0)
    |> Enum.uniq()
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map_reduce(
      [{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}],
      fn step, [head, knot | rest] ->
        {_, {new_head, new_knot}} = do_moves(step, head, knot)
        stuff = do_stuff([new_head, new_knot] ++ rest)

        {List.last(stuff), stuff}
      end
    )
    |> elem(0)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp do_moves(step, head, tail) do
    head = move(head, step)

    tail =
      case touching?(head, tail) do
        true -> tail
        false -> move(tail, determine_tail_step(head, tail))
      end

    {tail, {head, tail}}
  end

  defp do_stuff([head | []]), do: [head]

  defp do_stuff([head, tail | rest]) do
    tail =
      case touching?(head, tail) do
        true -> tail
        false -> move(tail, determine_tail_step(head, tail))
      end

    [head | do_stuff([tail | rest])]
  end

  defp move({x, y}, {sx, sy}), do: {x + sx, y + sy}

  defp determine_tail_step({hx, hy} = head, {tx, ty}) do
    possible_steps =
      case tx == hx || ty == hy do
        true -> [{1, 0}, {-1, 0}, {0, 1}, {0, -1}]
        false -> [{1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
      end

    possible_steps
    |> Enum.find(fn {sx, sy} -> touching?(head, {tx + sx, ty + sy}) end)
  end

  defp touching?(head, {tx, ty} = tail) do
    [
      tail,
      {tx + 1, ty},
      {tx - 1, ty},
      {tx, ty + 1},
      {tx, ty - 1},
      {tx + 1, ty + 1},
      {tx + 1, ty - 1},
      {tx - 1, ty + 1},
      {tx - 1, ty - 1}
    ]
    |> Enum.any?(&Kernel.==(&1, head))
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
