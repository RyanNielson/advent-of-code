defmodule Day06 do
  def part_1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.zip()
    |> Enum.map(fn problem ->
      operator = elem(problem, tuple_size(problem) - 1)

      problem
      |> Tuple.to_list()
      |> Enum.drop(-1)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(fn operand, acc ->
        case operator do
          "+" -> operand + acc
          "-" -> operand - acc
          "*" -> operand * acc
          "/" -> operand / acc
        end
      end)
    end)
    |> Enum.sum()
  end

  def part_2(input) do
    input
  end
end
