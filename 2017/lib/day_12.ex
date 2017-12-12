defmodule AdventOfCode2017.Day12 do
  def part1(input) do
    input
    |> parse()
    |> visit([0], MapSet.new())
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse()
    |> count_groups()
  end

  defp visit(graph, [next | rest], visited) do
    more_nodes = Enum.reject(graph[next], &MapSet.member?(visited, &1))

    visit(graph, more_nodes ++ rest, MapSet.put(visited, next))
  end

  defp visit(_, [], visited), do: visited

  defp count_groups(graph) do
    ids = Map.keys(graph)
    Enum.map_reduce(ids, MapSet.new(), fn (id, visited) ->
      case MapSet.member?(visited, id) do
        true  -> {nil, visited}
        false -> {id, visit(graph, [id], visited)}
      end
    end)
    |> elem(0)
    |> Enum.count(&(&1))
  end

  def parse(input) do
    input
    |> String.split((~r/\r\n|\r|\n/), trim: true)
    |> Enum.map(&String.split()/1)
    |> Enum.reduce(%{}, fn ([id, _ | conns], graph) ->
      conns = conns
      |> Enum.map(&String.trim(&1, ","))
      |> Enum.map(&String.to_integer/1)
      Map.put(graph, String.to_integer(id), conns)
    end)
  end
end