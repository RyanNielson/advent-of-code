defmodule Day06 do
  @doc """
  ## Examples
    iex>  Helpers.input("day_06_example_1") |> Day06.part1()
    42
    iex> Helpers.input("day_06") |> Day06.part1()
    358_244
  """
  def part1(input) do
    input
    |> parse()
    |> build_map()
    |> count_orbits()
  end

  @doc """
  ## Examples
    iex>  Helpers.input("day_06_example_2") |> Day06.part2()
    4
    iex> Helpers.input("day_06") |> Day06.part2()
    517
  """
  def part2(input) do
    input
    |> parse()
    |> build_map()
    |> count_orbital_transfers()
  end

  def build_map(orbits) do
    orbits
    |> Enum.reduce(%{}, fn {left, right}, map -> Map.put(map, right, left) end)
  end

  def count_orbits(map) do
    map
    |> Map.keys()
    |> Enum.flat_map(&build_path(&1, map))
    |> Enum.count()
  end

  def count_orbital_transfers(map) do
    you = build_path("YOU", map)
    san = build_path("SAN", map)
    intersection = MapSet.intersection(MapSet.new(you), MapSet.new(san))
    you_diff = MapSet.difference(MapSet.new(you), intersection)
    san_diff = MapSet.difference(MapSet.new(san), intersection)

    count =
      you_diff
      |> MapSet.union(san_diff)
      |> MapSet.size()

    count - 2
  end

  def build_path(object, _map) when object == "COM", do: []

  def build_path(object, map), do: [object | build_path(Map.get(map, object), map)]

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, ")") |> List.to_tuple()))
  end
end
