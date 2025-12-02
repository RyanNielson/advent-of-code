defmodule Day02 do
  def part_1(input) do
    input
    |> solve(fn id ->
      id_string = Integer.to_string(id)
      id_length = String.length(id_string)
      {left, right} = String.split_at(id_string, div(id_length, 2))
      rem(id_length, 2) == 0 and left == right
    end)
  end

  def part_2(input) do
    input
    |> solve(fn id ->
      id_string = Integer.to_string(id)
      (id_string <> id_string) |> String.slice(1..-2//1) |> String.contains?(id_string)
    end)
  end

  defp solve(input, invalid_func) do
    input
    |> String.split(",")
    |> Enum.map(fn range ->
      range |> String.split("-") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
    end)
    |> Enum.flat_map(fn {min, max} -> min..max |> Enum.filter(&invalid_func.(&1)) end)
    |> Enum.sum()
  end
end
