defmodule Day03 do
  @doc """
  ## Examples

    iex> Day03.part1("R8,U5,L5,D3\\nU7,R6,D4,L4")
    6

    iex> Day03.part1("R75,D30,R83,U83,L12,D49,R71,U7,L72\\nU62,R66,U55,R34,D71,R55,D58,R83")
    159

    iex> Day03.part1("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
    135

    iex> Helpers.input("day_03") |> Day03.part1()
    1519
  """
  def part1(input) do
    [path1, path2] =
      input
      |> parse()
      |> build_wires()
      |> Enum.map(fn path ->
        path |> Enum.map(&elem(&1, 0))
      end)
      |> Enum.map(&MapSet.new/1)

    MapSet.intersection(path1, path2)
    |> Enum.map(&manhattan_distance/1)
    |> Enum.min()
  end

  @doc """
  This is super ugly and could probably be improved by just using a map which has a key of position and value of distance.

  ## Examples

    iex> Day03.part2("R8,U5,L5,D3\\nU7,R6,D4,L4")
    30

    iex> Day03.part2("R75,D30,R83,U83,L12,D49,R71,U7,L72\\nU62,R66,U55,R34,D71,R55,D58,R83")
    610

    iex> Day03.part2("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
    410

    iex> Helpers.input("day_03") |> Day03.part2()
    14358
  """
  def part2(input) do
    wires =
      input
      |> parse()
      |> build_wires()

    [path1, path2] =
      wires
      |> Enum.map(fn path ->
        path |> Enum.map(&elem(&1, 0))
      end)
      |> Enum.map(&MapSet.new/1)

    MapSet.intersection(path1, path2)
    |> Enum.map(fn position ->
      {_, distance1} =
        wires
        |> Enum.at(0)
        |> Enum.find(fn {path_position, _} -> position == path_position end)

      {_, distance2} =
        wires
        |> Enum.at(1)
        |> Enum.find(fn {path_position, _} -> position == path_position end)

      distance1 + distance2
    end)
    |> Enum.min()
  end

  defp build_wires(paths), do: paths |> Enum.map(&build_wire/1)

  defp build_wire(path) do
    path
    |> Enum.flat_map_reduce({{0, 0}, 0}, fn instruction, acc ->
      new_positions = move(instruction, acc)
      {new_positions, Enum.at(new_positions, -1)}
    end)
    |> elem(0)
  end

  defp move({direction, amount}, start),
    do: new_positions(direction, String.to_integer(amount), start)

  # These could be simpified as they're basically doing the same thing.
  defp new_positions("U", amount, {{x, y}, distance}),
    do: 1..amount |> Enum.map(&{{x, y + &1}, distance + &1})

  defp new_positions("D", amount, {{x, y}, distance}),
    do: 1..amount |> Enum.map(&{{x, y - &1}, distance + &1})

  defp new_positions("L", amount, {{x, y}, distance}),
    do: 1..amount |> Enum.map(&{{x - &1, y}, distance + &1})

  defp new_positions("R", amount, {{x, y}, distance}),
    do: 1..amount |> Enum.map(&{{x + &1, y}, distance + &1})

  defp manhattan_distance({x, y}), do: abs(x) + abs(y)

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn path ->
      path
      |> String.split(",")
      |> Enum.map(&String.split_at(&1, 1))
    end)
  end
end
