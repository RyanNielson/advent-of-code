defmodule Day08 do
  def part_1(input, iterations) do
    {closest_pairs, starting} = prepare(input)

    closest_pairs
    |> Enum.reduce_while({starting, 0}, fn {p1, p2, _}, {circuits, count} ->
      new_circuits = connect(p1, p2, circuits)

      count = if circuits != new_circuits, do: count + 1, else: count

      if count == iterations, do: {:halt, new_circuits}, else: {:cont, {new_circuits, count}}
    end)
    |> Enum.sort_by(&MapSet.size/1, :desc)
    |> Enum.take(3)
    |> Enum.map(&MapSet.size/1)
    |> Enum.product()
  end

  def part_2(input) do
    {closest_pairs, starting} = prepare(input)

    {{x1, _, _}, {x2, _, _}} =
      closest_pairs
      |> Enum.reduce_while(starting, fn {p1, p2, _}, circuits ->
        new_circuits = connect(p1, p2, circuits)

        if length(new_circuits) == 1, do: {:halt, {p1, p2}}, else: {:cont, new_circuits}
      end)

    x1 * x2
  end

  defp prepare(input) do
    positions =
      input
      |> String.split()
      |> Enum.map(fn line ->
        line |> String.split(",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      end)

    neighbours =
      positions
      |> Enum.flat_map(fn p1 ->
        positions
        |> Enum.reject(&(&1 == p1))
        |> Enum.map(fn p2 -> {p1, p2, distance(p1, p2)} end)
      end)

    closest_pairs =
      neighbours
      |> Enum.reduce({[], MapSet.new()}, fn {p1, p2, d}, {acc, seen} ->
        key = MapSet.new([p1, p2])

        if MapSet.member?(seen, key) do
          {acc, seen}
        else
          {[{p1, p2, d} | acc], MapSet.put(seen, key)}
        end
      end)
      |> elem(0)
      |> Enum.sort(fn {_, _, d1}, {_, _, d2} -> d1 < d2 end)

    starting = positions |> Enum.map(fn position -> MapSet.new([position]) end)

    {closest_pairs, starting}
  end

  defp connect(p1, p2, circuits) do
    found_1 = Enum.find(circuits, &MapSet.member?(&1, p1))
    found_2 = Enum.find(circuits, &MapSet.member?(&1, p2))

    cond do
      found_1 != nil and found_2 != nil ->
        new_circuits =
          circuits
          |> List.delete(found_1)
          |> List.delete(found_2)

        [MapSet.union(found_1, found_2) | new_circuits]

      found_1 != nil ->
        new_circuits = circuits |> List.delete(found_1)
        [MapSet.put(found_1, p2) | new_circuits]

      found_2 != nil ->
        new_circuits = circuits |> List.delete(found_2)
        [MapSet.put(found_2, p1) | new_circuits]

      true ->
        [MapSet.new([p1, p2]) | circuits]
    end
  end

  defp distance({x1, y1, z1}, {x2, y2, z2}) do
    :math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2 + (z2 - z1) ** 2)
  end
end
