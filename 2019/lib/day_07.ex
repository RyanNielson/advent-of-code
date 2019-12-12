defmodule Day07 do
  @doc """
  ## Examples
    iex> Day07.part1("3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0")
    43210
    iex> Day07.part1("3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0")
    54321
    iex> Day07.part1("3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0")
    65210
    iex> Helpers.input("day_07") |> Day07.part1()
    19650
  """
  def part1(input) do
    program =
      input
      |> Helpers.parse_to_integer_list(",")

    permutations([0, 1, 2, 3, 4])
    |> Enum.map(fn phases ->
      phases
      |> Enum.reduce(0, fn phase, signal ->
        program
        |> Intcode.init([phase, signal])
        |> Intcode.run()
        |> Intcode.output()
        |> List.first()
      end)
    end)
    |> Enum.max()
  end

  def permutations([]), do: [[]]

  def permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])
end
