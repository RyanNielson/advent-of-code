# TODO: Can this just be in the module?
defmodule Overloads do
  def a <<< b, do: a + b
  def a >>> b, do: a * b
end

defmodule Day18 do
  import Overloads

  def part1(input) do
    input
    |> parse_1()
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
end
