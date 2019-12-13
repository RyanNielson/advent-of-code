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

  @doc """
  ## Examples
    iex> Day07.part2("3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5")
    139_629_729
    iex> Day07.part2("3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10")
    18216
    iex> Helpers.input("day_07") |> Day07.part2()
    35961106
  """
  def part2(input) do
    program =
      input
      |> Helpers.parse_to_integer_list(",")

    permutations([5, 6, 7, 8, 9])
    |> Enum.map(fn phases ->
      phases
      |> Enum.map(&(program |> Intcode.init([&1])))
      |> run([0])
      |> List.first()
    end)
    |> Enum.max()
  end

  def run(amplifiers, input \\ [0]) do
    case Enum.all?(amplifiers, &Intcode.halted?(&1)) do
      true ->
        input

      false ->
        {new_amplifiers, output} =
          amplifiers
          |> Enum.map_reduce(input, fn amplifier, input ->
            amplifier |> Intcode.run(input) |> Intcode.pop_output()
          end)

        run(new_amplifiers, output)
    end
  end

  def permutations([]), do: [[]]

  def permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])
end
