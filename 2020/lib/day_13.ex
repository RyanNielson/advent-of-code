defmodule Day13 do
  def part1(input) do
    {earliest_departure, ids} =
      input
      |> parse()

    {next_id, next_time} =
      ids
      |> Enum.map(fn id ->
        {id, earliest_departure - rem(earliest_departure, id) + id}
      end)
      |> Enum.sort(fn {_, a}, {_, b} -> a <= b end)
      |> List.first()

    next_id * (next_time - earliest_departure)
  end

  defp parse(input) do
    [earliest, id_string] =
      input
      |> String.split("\n", trim: true)

    ids =
      id_string
      |> String.split(",")
      |> Enum.reject(&(&1 == "x"))
      |> Enum.map(&String.to_integer/1)

    {String.to_integer(earliest), ids}
  end
end
