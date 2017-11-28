defmodule Day05Part1 do
  def run(path) do
    IO.puts "Part 1: " <> to_string(nice_count(lines(path)))
  end

  def nice_count(lines), do: Enum.count(lines, &nice?/1)
  def nice?(line), do: three_vowels?(line) && !contains_sequence?(line) && repeating_letter?(line)
  def three_vowels?(line), do: Regex.scan(~r/[aeiou]/i, line) |> length >= 3
  def contains_sequence?(line), do: String.contains?(line, ["ab", "cd", "pq", "xy"])
  def repeating_letter?(line), do: Regex.match? ~r/(.)\1/, line
  defp lines(path), do: File.read!(path) |> String.split("\n", trim: true)
end

# defmodule Day05Part2 do
#   def run(path) do
#     IO.inspect nice_count(lines(path))
#
#     IO.inspect lines(path)
#   end
#
#   def nice_count(lines), do: Enum.count(lines, &nice?/1)
#   def nice?(line), do: three_vowels?(line) && !contains_sequence?(line) && repeating_letter?(line)
#   def three_vowels?(line), do: Regex.scan(~r/[aeiou]/i, line) |> length >= 3
#   def contains_sequence?(line), do: String.contains?(line, ["ab", "cd", "pq", "xy"])
#   def repeating_letter?(line), do: Regex.match? ~r/(.)\1/, line
#   defp lines(path), do: File.read!(path) |> String.split("\n", trim: true)
# end

Day05.run("day05.input")
