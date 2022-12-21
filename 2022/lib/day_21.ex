defmodule Day21 do
  def part1(input) do
    monkeys =
      input
      |> parse()

    yell(monkeys, Map.get(monkeys, :root))
  end

  def part2(input) do
    input
  end

  defp yell(_, a) when is_integer(a), do: a

  defp yell(monkeys, {a, b, job}) do
    Code.eval_string(job, [
      {a, yell(monkeys, Map.get(monkeys, a))},
      {b, yell(monkeys, Map.get(monkeys, b))}
    ])
    |> elem(0)
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.into(%{}, fn line ->
      [name, job] = String.split(line, ": ")

      job =
        case Integer.parse(job) do
          :error ->
            [a, _, b] = job |> String.split(" ") |> Enum.map(&String.to_atom/1)
            {a, b, job}

          {number, _} ->
            number
        end

      {String.to_atom(name), job}
    end)
  end
end
