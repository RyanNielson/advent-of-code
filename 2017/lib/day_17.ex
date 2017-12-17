defmodule AdventOfCode2017.Day17 do
  @total_steps 2017

  def part1(input) do
    {values, index} = spinlock([0], parse(input))
    Enum.at(values, index + 1)
  end

  def spinlock(values, steps, current \\ 1, pos \\ 0)
  def spinlock(values, _, current, position) when current > @total_steps, do: {values, position}
  def spinlock(values, steps, current, position) do
    new_position = rem(position + steps, current) + 1

    values
    |> List.insert_at(new_position, current)
    |> spinlock(steps, current + 1, new_position)
  end

  def parse(input), do: input |> String.to_integer()
 end