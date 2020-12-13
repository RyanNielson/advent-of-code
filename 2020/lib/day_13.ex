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

  def part2(input) do
    input
    |> parse2()
    |> Enum.reduce(fn {next_id, next_offset}, {jump, timestamp} ->
      next =
        timestamp
        |> Stream.iterate(&(&1 + jump))
        |> Enum.find(&(rem(&1 + next_offset, next_id) == 0))

      {jump * next_id, next}
    end)
    |> elem(1)
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

  defp parse2(input) do
    [_, id_string] =
      input
      |> String.split("\n", trim: true)

    id_string
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.reject(fn {id, _} -> id == "x" end)
    |> Enum.map(fn {id, offset} -> {String.to_integer(id), offset} end)
  end
end
