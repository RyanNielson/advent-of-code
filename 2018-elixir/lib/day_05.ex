defmodule AdventOfCode2018.Day05 do
  def part1(input) do
    input
    |> remove_reacting_units()
    |> Enum.count()
  end

  def part2(input) do
    ?a..?z
    |> Enum.map(fn(x) -> <<x :: utf8>> end)
    |> Enum.map(fn(thing) ->
      remove_reacting_units(String.replace(input, ~r/#{thing}/i, "")) |> Enum.count()
    end)
    |> Enum.min()
    # ?a..?z
    # |> Enum.to_list
    # |> Enum.map(&IO.inspect/1)
    # ?a..?z
    # |> Enum.map(fn(x) ->
    #   thing = <<x :: utf8>>
    #   remove_reacting_units(String.replace(input, ~r/#{thing}/i, "")) |> Enum.count()
    # end)
    # |> Enum.min()
  end

  def remove_reacting_units(polymers) do
    polymers
    |> String.codepoints()
    |> Enum.reduce([], &react/2)
  end

  def react(unit, []), do: [unit]

  def react(unit, [next | rest]) do
    if opposite_polarity?(unit, next) do
      rest
    else
      [unit, next | rest]
    end
  end

  ?a..?z |> Enum.to_list |> List.to_string

  def opposite_polarity?(a, b) do
    a != b && String.downcase(a) == String.downcase(b)
  end
end