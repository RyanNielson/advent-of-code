defmodule AdventOfCode2017.Day09 do
  def part1(input), do: input |> group(1)

  def part2(input), do: input |> group_2(0)
  
  defp group("{" <> rest, level), do: level + group(rest, level + 1)
  defp group("}" <> rest, level), do: group(rest, level - 1)
  defp group("<" <> rest, level), do: garbage(rest, level)
  defp group(<<_::binary-size(1)>> <> rest, level), do: group(rest, level)
  defp group("", _), do: 0

  defp garbage("!" <> <<_::binary-size(1)>> <> rest, level), do: garbage(rest, level)
  defp garbage(">" <> rest, level), do: group(rest, level)
  defp garbage(<<_::binary-size(1)>> <> rest, level), do: garbage(rest, level)

  defp group_2("{" <> rest, count), do: group_2(rest, count)
  defp group_2("}" <> rest, count), do: group_2(rest, count)
  defp group_2("<" <> rest, count), do: garbage_2(rest, count)
  defp group_2(<<_::binary-size(1)>> <> rest, count), do: group_2(rest, count)
  defp group_2("", count), do: count

  defp garbage_2("!" <> <<_::binary-size(1)>> <> rest, count), do: garbage_2(rest, count)
  defp garbage_2(">" <> rest, count), do: group_2(rest, count)
  defp garbage_2(<<_::binary-size(1)>> <> rest, count), do: garbage_2(rest, count + 1)
end