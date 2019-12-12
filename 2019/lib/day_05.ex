defmodule Day05 do
  @doc """
  ## Examples

    iex> Helpers.input("day_05") |> Day05.part1()
    5_821_753
  """
  def part1(input) do
    input
    |> parse()
    |> Intcode.init([1])
    |> Intcode.run()
    |> Intcode.output()
    |> List.first()
  end

  @doc """
  ## Examples

    iex> Day05.part2("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", 0)
    0
    iex> Day05.part2("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", 11)
    1
    iex> Day05.part2("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", 0)
    0
    iex> Day05.part2("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", 55)
    1
    iex> Day05.part2("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99", 6)
    999
    iex> Day05.part2("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99", 8)
    1000
    iex> Day05.part2("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99", 23)
    1001
    iex> Helpers.input("day_05") |> Day05.part2(5)
    11_956_381
  """
  def part2(input, val) do
    input
    |> parse()
    |> Intcode.init([val])
    |> Intcode.run()
    |> Intcode.output()
    |> List.first()
  end

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
