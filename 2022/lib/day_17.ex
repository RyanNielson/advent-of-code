defmodule Day17 do
  def part1(input) do
    # Would be cool if we could make this a stream.
    jets =
      input
      |> parse()
      |> List.to_tuple()

    jets_size = tuple_size(jets)

    shapes()
    |> Stream.cycle()
    |> Enum.take(2022)
    |> Enum.reduce({MapSet.new(), 0}, fn rock, {cave, jet_i} ->
      max = if Enum.empty?(cave), do: {0, -1}, else: cave |> Enum.max_by(fn {_, y} -> y end)
      move_rock(rock, {2, elem(max, 1) + 4}, cave, jets, jet_i)
    end)
    |> elem(0)
    |> Enum.max_by(fn {_, y} -> y end)
    |> elem(1)
    |> Kernel.+(1)
  end

  def part2(input) do
    # jets =
    #   input
    #   |> parse()
    #   |> List.to_tuple()

    # jets_size = tuple_size(jets)

    # shapes()
    # |> Stream.cycle()
    # # |> Enum.take(1_000_000_000_000)
    # |> Stream.take(1_000_000_000_000)
    # |> Enum.reduce({MapSet.new(), 0}, fn rock, {cave, jet_i} ->
    #   # IO.inspect("WEE")
    #   max = if Enum.empty?(cave), do: {0, -1}, else: cave |> Enum.max_by(fn {_, y} -> y end)
    #   move_rock(rock, {2, elem(max, 1) + 4}, cave, jets, jet_i)
    # end)
    # |> elem(0)
    # |> Enum.max_by(fn {_, y} -> y end)
    # |> elem(1)
    # |> Kernel.+(1)
  end

  defp move_rock(rock, position, cave, jets, jet_i) do
    position = push(rock, position, elem(jets, Integer.mod(jet_i, tuple_size(jets))), cave)

    case fall(rock, position, cave) do
      {:cont, new_position} ->
        move_rock(rock, new_position, cave, jets, jet_i + 1)

      {:halt, {px, py}} ->
        {MapSet.union(cave, MapSet.new(rock, fn {x, y} -> {x + px, y + py} end)), jet_i + 1}
    end
  end

  defp fall(rock, {rx, ry} = position, cave) do
    hit =
      rock
      |> Enum.any?(fn {x, y} ->
        new_position = {rx + x, ry + y - 1}
        elem(new_position, 1) < 0 || MapSet.member?(cave, new_position)
      end)

    if hit, do: {:halt, position}, else: {:cont, {rx, ry - 1}}
  end

  defp push(rock, {rx, ry} = position, "<", cave) do
    hit =
      rock
      |> Enum.any?(fn {x, y} ->
        new_position = {rx + x - 1, ry + y}

        elem(new_position, 0) < 0 || elem(new_position, 0) >= 7 ||
          MapSet.member?(cave, new_position)
      end)

    if hit, do: position, else: {rx - 1, ry}
  end

  defp push(rock, {rx, ry} = position, ">", cave) do
    hit =
      rock
      |> Enum.any?(fn {x, y} ->
        new_position = {rx + x + 1, ry + y}

        elem(new_position, 0) < 0 || elem(new_position, 0) >= 7 ||
          MapSet.member?(cave, new_position)
      end)

    if hit, do: position, else: {rx + 1, ry}
  end

  def part2(input) do
    input
  end

  defp shapes() do
    # MIGHT WANNA ORDER THESE HEIGHT TO LOWEST in Y
    # Might want to make these tuples and store the top left and bottom edge.
    # Zero y is top
    # [
    #   MapSet.new([{0, 0}, {1, 0}, {2, 0}, {3, 0}]),
    #   MapSet.new([{1, 0}, {0, 1}, {1, 1}, {2, 1}, {1, 2}]),
    #   MapSet.new([{2, 0}, {2, 1}, {0, 2}, {1, 2}, {2, 2}]),
    #   MapSet.new([{0, 0}, {0, 1}, {0, 2}, {0, 3}]),
    #   MapSet.new([{0, 0}, {1, 0}, {0, 1}, {1, 1}])
    # ]

    # Zero y is bottom
    [
      MapSet.new([{0, 0}, {1, 0}, {2, 0}, {3, 0}]),
      MapSet.new([{1, 0}, {0, 1}, {1, 1}, {2, 1}, {1, 2}]),
      MapSet.new([{0, 0}, {1, 0}, {2, 0}, {2, 1}, {2, 2}]),
      MapSet.new([{0, 0}, {0, 1}, {0, 2}, {0, 3}]),
      MapSet.new([{0, 0}, {1, 0}, {0, 1}, {1, 1}])
    ]
  end

  defp parse(input) do
    input
    |> String.codepoints()
  end
end
