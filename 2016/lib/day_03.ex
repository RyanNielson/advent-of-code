defmodule Day03 do
  def run(input) do
    input
    |> parse
    |> count_valid_triangles
  end

  def parse(input) do
    input
    |> String.trim
    |> String.split([" ", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk(3)
  end

  def count_valid_triangles(triangles) do
    triangles
    |> Enum.filter(fn [a, b, c] -> a + b > c and a + c > b and b + c > a end)
    |> Enum.count
  end
end
