defmodule AdventOfCode2017.Day07 do
  # @name_pattern ~r/(\w+) \((\d+)\)/
  # @name_holding_pattern ~r/(\w+) \((\d+)\) \-\> (.+)/

  def part1(input) do
    input
    |> parse
    |> find_bottom
  end

  def parse(input) do
    input
    |> String.split((~r/\r\n|\r|\n/), trim: true)
    |> Enum.map(&build_program(Regex.scan(~r/\w+/, &1)))
  end

  def build_program([[name], [weight] | above]) do
    [name, String.to_integer(weight), List.flatten(above)]
  end

  # TODO: Might be able to just use MapSet
  def find_bottom(tower) do
    names = Enum.map(tower, &List.first/1)
    names_above = tower
    |> Enum.reduce([], &(List.last(&1) ++ &2))
    |> Enum.uniq

    List.first(names -- names_above)
  end
end