defmodule AdventOfCode2017.Day07 do
  # @name_pattern ~r/(\w+) \((\d+)\)/
  # @name_holding_pattern ~r/(\w+) \((\d+)\) \-\> (.+)/

  def part1(input) do
    input
    |> parse
    |> find_bottom
  end

  def part2(input) do
    input
    |> parse
    |> to_map_with_root
    |> balance
  end

  def parse(input) do
    input
    |> String.split((~r/\r\n|\r|\n/), trim: true)
    |> Enum.map(&build_program(Regex.scan(~r/\w+/, &1)))
  end

  def to_map_with_root(programs) do
    graph = programs
    |> Enum.into(%{}, fn [name, weight, above] ->
      {name, %{:name => name, :weight => weight, :above => above}}
    end)

    {graph, find_bottom(programs)}
  end

  def balance({graph, root}) do
    node = graph[root]
    handle_weights(graph, root)
  end

  def handle_weights(graph, name) do
    node = graph[name]

    IO.inspect "OK"
    IO.inspect node

    node.above
    |>Enum.map(&handle_weights(graph, &1))
  end

  # def handle_weights(graph, name) do
  #   IO.inspect "OTHER"
  #   IO.inspect node
  # end

  def build_program([[name], [weight] | above]) do
    [name, String.to_integer(weight), List.flatten(above)]
  end

  def find_bottom(tower) do
    names = Enum.map(tower, &List.first/1)
    names_above = tower
    |> Enum.reduce([], &(List.last(&1) ++ &2))
    |> Enum.uniq

    List.first(names -- names_above)
  end
end