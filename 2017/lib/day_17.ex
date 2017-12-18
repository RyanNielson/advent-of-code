defmodule AdventOfCode2017.Day17 do
  @total_steps 2017
  @total_steps_2 50_000_000

  def part1(input) do
    {values, index} = spinlock([0], parse(input))
    Enum.at(values, index + 1)
  end

  def part2(input) do
    short_circuit(0, parse(input))
  end

  def spinlock(values, steps, current \\ 1, pos \\ 0)
  def spinlock(values, _, current, position) when current > @total_steps, do: {values, position}
  def spinlock(values, steps, current, position) do
    new_position = rem(position + steps, current) + 1

    values
    |> List.insert_at(new_position, current)
    |> spinlock(steps, current + 1, new_position)
  end

  def short_circuit(value, steps, current \\ 1, pos \\ 0)
  def short_circuit(value, _, current, _) when current > @total_steps_2, do: value
  def short_circuit(value, steps, current, position) do
    new_position = rem(position + steps, current) + 1
    new_value = if new_position == 1, do: current, else: value

    short_circuit(new_value, steps, current + 1, new_position)
  end

  def parse(input), do: input |> String.to_integer()
 end