defmodule AdventOfCode2017.Day09 do
  def part1(input) do
    input
    |> parse()
    |> handle(1)
  end

  def part2(input) do
    input
    |> parse()
    |> handle_2(0)
  end

  # TODO: Switch to pattern matching on strings instead.
  defp handle(["{" | rest], level), do: level + handle(rest, level + 1)
  defp handle(["}" | rest], level), do: handle(rest, level - 1)
  defp handle(["<" | rest], level), do: garbage(rest, level)
  defp handle([_ | rest], level), do: handle(rest, level)
  defp handle([], _), do: 0

  defp garbage(["!", _ | rest], level), do: garbage(rest, level)
  defp garbage([">" | rest], level), do: handle(rest, level)
  defp garbage([_ | rest], level), do: garbage(rest, level)


  defp handle_2(["{" | rest], garbage_count), do: handle_2(rest, garbage_count)
  defp handle_2(["}" | rest], garbage_count), do: handle_2(rest, garbage_count)
  defp handle_2(["<" | rest], garbage_count), do: garbage_2(rest, garbage_count)
  defp handle_2([_ | rest], garbage_count), do: handle_2(rest, garbage_count)
  defp handle_2([], garbage_count), do: garbage_count

  defp garbage_2(["!", _ | rest], garbage_count), do: garbage_2(rest, garbage_count)
  defp garbage_2([">" | rest], garbage_count), do: handle_2(rest, garbage_count)
  defp garbage_2([_ | rest], garbage_count), do: garbage_2(rest, garbage_count + 1)

  defp parse(input), do: input |> String.split("", trim: true)

  # def tt(<<c::utf8>> <> rest) do
  #   IO.inspect(c)
  #   IO.inspect(rest)
  # end

  # def tt2(<<c::binary-size(1), rest::binary>>) do
  #   IO.inspect(c)
  #   IO.inspect(rest)
  # end
end