# Overload operators to change precedence so that Code.eval_string
# can do the heavy lifting for us.
defmodule Overloads do
  def a <<< b, do: a + b
  def a >>> b, do: a * b
  def a &&& b, do: a * b
end

defmodule Day18 do
  import Overloads

  def part1(input) do
    input
    |> parse_1()
    |> solve()
  end

  def part2(input) do
    input
    |> parse_2()
    |> solve()
  end

  def solve(expressions) do
    expressions
    |> Enum.map(&Code.eval_string(&1, [], __ENV__))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp parse_1(input) do
    input
    |> String.replace("+", "<<<")
    |> String.replace("*", ">>>")
    |> String.split("\n", trim: true)
  end

  defp parse_2(input) do
    input
    |> String.replace("+", "<<<")
    |> String.replace("*", "&&&")
    |> String.split("\n", trim: true)
  end
end
