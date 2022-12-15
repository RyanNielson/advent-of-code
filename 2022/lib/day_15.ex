defmodule Day15 do
  def part1(input, check_y) do
    {sensors, beacons, min_x, max_x} =
      input
      |> parse()
      |> Enum.reduce({%{}, MapSet.new(), nil, nil}, fn {{sx, sy} = sensor, {bx, by} = beacon},
                                                       {sensors, beacons, min, max} ->
        d = manhattan_distance({sx, sy}, {bx, by})
        {smin, smax} = (sx - d)..(sx + d) |> Enum.min_max()

        new_min = if min, do: if(smin < min, do: smin, else: min), else: smin
        new_max = if max, do: if(smax > max, do: smax, else: max), else: smax

        {
          Map.put(sensors, sensor, d),
          MapSet.put(beacons, beacon),
          new_min,
          new_max
        }
      end)

    # TODO: Figure out why this is one off.
    min_x..max_x
    |> Enum.count(fn x ->
      position = {x, check_y}
      !Map.has_key?(sensors, position) && !MapSet.member?(beacons, position)
      Enum.any?(sensors, fn {sensor, v} -> manhattan_distance(sensor, {x, check_y}) <= v end)
    end)
    |> Kernel.-(1)
  end

  def part2(input, max) do
    {sensors, checks} =
      input
      |> parse()
      |> Enum.reduce({%{}, []}, fn {{sx, sy} = sensor, {bx, by}}, {sensors, checks} ->
        d = manhattan_distance({sx, sy}, {bx, by})
        min_y = sy - d - 1
        max_y = sy + d + 1

        spots =
          min_y..max_y
          |> Stream.flat_map(fn y ->
            min_x = sx - d + abs(y - sy) - 1
            max_x = sx + d - abs(y - sy) + 1

            cond do
              y == min_y -> [{sx, min_y}]
              y == max_y -> [{sx, max_y}]
              true -> [{min_x, y}, {max_x, y}]
            end
          end)

        {
          Map.put(sensors, sensor, d),
          [spots | checks]
        }
      end)

    checks
    |> Enum.reduce([], fn checks, acc ->
      checks
      |> Enum.reduce(acc, fn {x, y} = position, acc ->
        if x >= 0 && x <= max && y >= 0 && y <= max &&
             Enum.all?(sensors, fn {sensor, v} -> manhattan_distance(sensor, position) > v end),
           do: [position | acc],
           else: acc
      end)
    end)
    |> List.first()
    |> then(fn {x, y} -> x * 4_000_000 + y end)
  end

  defp manhattan_distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      ~r/Sensor at x=(.+), y=(.+): closest beacon is at x=(.+), y=(.+)/
      |> Regex.run(line, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)
      |> then(fn [sx, sy, bx, by] -> {{sx, sy}, {bx, by}} end)
    end)
  end
end
