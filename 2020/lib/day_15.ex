defmodule Day15 do
  def part1(input) do
    input
    |> parse()
    |> play(2020)
  end

  def part2(input) do
    input
    |> parse()
    |> play(30_000_000)
  end

  defp play(starting_numbers, turns) do
    starting_state =
      Enum.slice(starting_numbers, 0..-2)
      |> Enum.with_index(1)
      |> Enum.into(%{})

    Enum.count(starting_numbers)..(turns - 1)
    |> Enum.reduce({starting_state, List.last(starting_numbers)}, fn num, {said, previous} ->
      next_spoken =
        case Map.get(said, previous) do
          nil -> 0
          x -> num - x
        end

      {Map.put(said, previous, num), next_spoken}
    end)
    |> elem(1)
  end

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
