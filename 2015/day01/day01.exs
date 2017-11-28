defmodule Day01 do
  def run(path) do
    IO.puts "Part 1: " <> to_string(get_floor(path))
    IO.puts "Part 2: " <> to_string(get_first_basement(path) + 1)
  end

  def get_floor(path), do: count_floors(characters(path)) |> elem(1)

  def get_first_basement(path) do
    count_floors(characters(path))
    |> elem(0)
    |> Enum.find_index(fn(floor) -> floor == -1 end)
  end

  defp characters(path), do: String.split(File.read!(path), ~r//)

  defp count_floors(chars), do: Enum.map_reduce(chars, 0, &count_floors/2)
  defp count_floors(char, acc), do: { acc + char_value(char), acc + char_value(char)}

  defp char_value(_char = "("), do: 1
  defp char_value(_char = ")"), do: -1
  defp char_value(_char), do: 0
end

Day01.run("day01.input")
