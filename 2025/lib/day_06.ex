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
    |> String.split("\n", trim: false)
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.chunk_by(fn col ->
      Enum.any?(col, &(&1 in ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]))
    end)
    |> Enum.map(fn group ->
      group
      |> Enum.map_reduce(nil, fn operand, operator ->
        operator =
          cond do
            "+" in operand -> "+"
            "-" in operand -> "-"
            "*" in operand -> "*"
            "/" in operand -> "/"
            true -> operator
          end

        operand =
          operand
          |> Enum.join("")
          |> String.replace([" ", "+", "-", "*", "/"], "")
          |> String.trim()

        {operand, operator}
      end)
    end)
    |> Enum.reject(fn {_operands, operator} -> is_nil(operator) end)
    |> Enum.map(fn {operands, operator} ->
      operands
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
end
