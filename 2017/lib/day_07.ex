defmodule AdventOfCode2017.Day07 do
  @name_pattern ~r/(\w+) \((\d+)\)/
  @name_holding_pattern ~r/(\w+) \((\d+)\) \-\> (.+)/

  def part1(input) do
    input
    |> parse
    |> find_bottom
  end

  def parse(input) do
    input
    |> String.split((~r/\r\n|\r|\n/), trim: true)
    |> Enum.map(fn (line) ->
      if (String.match?(line, ~r/\-\>/)) do
        [_, name, weight, above] = Regex.run(@name_holding_pattern, line)
        [name, String.to_integer(weight), String.split(above, ~r/(\W+)/)]
      else
        [_, name, weight] = Regex.run(@name_pattern, line)
        [name, String.to_integer(weight), []]
      end
    end)
  end

  def find_bottom(tower) do
    names = Enum.map(tower, &List.first/1)
    names_above = tower
    |> Enum.reduce([], &(List.last(&1) ++ &2))
    |> Enum.uniq

    List.first(names -- names_above)
  end
end