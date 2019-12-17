defmodule Day17 do
  @doc """
  ## Examples
    iex> Helpers.input("day_17") |> Day17.part1()
    7720
  """
  def part1(input) do
    grid =
      input
      |> parse()
      |> Intcode.init()
      |> Intcode.run()
      |> Intcode.output()
      |> to_string()
      |> String.trim()
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {row, y}, acc ->
        new_map =
          row
          |> String.split("", trim: true)
          |> Enum.with_index()
          |> Enum.into(%{}, fn {value, x} -> {{x, y}, value} end)

        Map.merge(acc, new_map)
      end)

    grid
    |> Enum.filter(fn {position, _} ->
      intersection?(grid, position)
    end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.sum()
  end

  @doc """
  ## Examples
    iex> Helpers.input("day_17") |> Day17.part2()
    1681189
  """
  def part2(input) do
    input
      |> parse()
      |> List.replace_at(0, 2)
      |> Intcode.init('A,B,A,B,C,C,B,A,B,C\nL,10,R,10,L,10,L,10\nR,10,R,12,L,12\nR,12,L,12,R,6\nn\n')
      |> Intcode.run()
      |> Intcode.output()
      |> List.last()
  end

  defp scaffold?(grid, position) do
    Map.get(grid, position, ".") == "#"
  end

  defp intersection?(grid, {x, y}) do
    scaffold?(grid, {x, y}) and scaffold?(grid, {x + 1, y}) and scaffold?(grid, {x - 1, y}) and
      scaffold?(grid, {x, y + 1}) and scaffold?(grid, {x, y - 1})
  end

  def parse(input) do
    input
    |> Helpers.parse_to_integer_list(",")
  end
end
