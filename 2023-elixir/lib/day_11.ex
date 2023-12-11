defmodule Day11 do
  def part_1(input) do
    input
    |> parse()
    |> expand()
    |> total_path_lengths()
  end

  def part_2(input) do
    input
    |> parse()
    |> expand(1_000_000)
    |> total_path_lengths()
  end

  def total_path_lengths(galaxies) do
    galaxies
    |> Enum.with_index(1)
    |> Enum.flat_map(fn {{x1, y1}, i} ->
      galaxies
      |> Enum.drop(i)
      |> Enum.map(fn {x2, y2} -> abs(x2 - x1) + abs(y2 - y1) end)
    end)
    |> Enum.sum()
  end

  def expand(galaxies, amount \\ 2) do
    x_positions = galaxies |> Enum.map(&elem(&1, 0)) |> MapSet.new()
    y_positions = galaxies |> Enum.map(&elem(&1, 1)) |> MapSet.new()

    galaxies
    |> Enum.map(fn {x, y} ->
      x_padding = 0..x |> Enum.count(fn x -> !MapSet.member?(x_positions, x) end)
      y_padding = 0..y |> Enum.count(fn y -> !MapSet.member?(y_positions, y) end)

      {x + x_padding * (amount - 1), y + y_padding * (amount - 1)}
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, x} -> if char == "#", do: {x, y}, else: nil end)
      |> Enum.reject(&is_nil/1)
    end)
  end
end
