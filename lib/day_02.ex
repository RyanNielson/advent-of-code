defmodule Day02 do
  def run(input) do
    input
    |> parse
    |> generate_code(5, [])
  end

  def parse(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
  end

  def generate_code([group | moves], button, result) do
    new_button = walk(group, button);
    generate_code(moves, new_button, [new_button | result])
  end

  def generate_code([], _button, result), do: result |> Enum.reverse |> Enum.join

  defp walk(["R" | moves], 1), do: walk(moves, 2)
  defp walk(["D" | moves], 1), do: walk(moves, 2)
  defp walk(["R" | moves], 2), do: walk(moves, 3)
  defp walk(["D" | moves], 2), do: walk(moves, 5)
  defp walk(["L" | moves], 2), do: walk(moves, 1)
  defp walk(["D" | moves], 3), do: walk(moves, 6)
  defp walk(["L" | moves], 3), do: walk(moves, 2)
  defp walk(["U" | moves], 4), do: walk(moves, 1)
  defp walk(["R" | moves], 4), do: walk(moves, 5)
  defp walk(["D" | moves], 4), do: walk(moves, 7)
  defp walk(["U" | moves], 5), do: walk(moves, 2)
  defp walk(["R" | moves], 5), do: walk(moves, 6)
  defp walk(["D" | moves], 5), do: walk(moves, 8)
  defp walk(["L" | moves], 5), do: walk(moves, 4)
  defp walk(["U" | moves], 6), do: walk(moves, 3)
  defp walk(["D" | moves], 6), do: walk(moves, 9)
  defp walk(["L" | moves], 6), do: walk(moves, 5)
  defp walk(["U" | moves], 7), do: walk(moves, 4)
  defp walk(["R" | moves], 7), do: walk(moves, 8)
  defp walk(["U" | moves], 8), do: walk(moves, 5)
  defp walk(["R" | moves], 8), do: walk(moves, 9)
  defp walk(["L" | moves], 8), do: walk(moves, 7)
  defp walk(["U" | moves], 9), do: walk(moves, 6)
  defp walk(["L" | moves], 9), do: walk(moves, 8)
  defp walk([_ | moves], button), do: walk(moves, button)
  defp walk([], key), do: key
end
