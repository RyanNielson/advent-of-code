defmodule Day21 do
  def part1(input) do
    monkeys =
      input
      |> parse()

    yell(monkeys, Map.get(monkeys, "root"))
  end

  def part2(input) do
    input
  end

  defp yell(_, a) when is_integer(a), do: a

  defp yell(monkeys, {a, op, b}) do
    case op do
      "+" -> yell(monkeys, Map.get(monkeys, a)) + yell(monkeys, Map.get(monkeys, b))
      "-" -> yell(monkeys, Map.get(monkeys, a)) - yell(monkeys, Map.get(monkeys, b))
      "*" -> yell(monkeys, Map.get(monkeys, a)) * yell(monkeys, Map.get(monkeys, b))
      "/" -> div(yell(monkeys, Map.get(monkeys, a)), yell(monkeys, Map.get(monkeys, b)))
    end
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.into(%{}, fn line ->
      [name, job] = String.split(line, ": ")

      job =
        case Integer.parse(job) do
          :error -> job |> String.split(" ") |> List.to_tuple()
          {number, _} -> number
        end

      {name, job}
    end)
  end
end
