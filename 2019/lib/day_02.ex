defmodule Day02 do
  @doc """
  ## Examples

    iex> Helpers.input("day_02") |> Day02.part1()
    7_594_646
  """
  def part1(input) do
    input
    |> parse()
    |> set_noun_and_verb(12, 2)
    |> Intcode.init()
    |> Intcode.run()
    |> Intcode.memory()
    |> Map.get(0)

    # Map.get(memory, 0)
  end

  @doc """
  ## Examples

    iex> Helpers.input("day_02") |> Day02.part2()
    3376
  """
  def part2(input) do
    program = input |> parse()

    results =
      for noun <- 0..99, verb <- 0..99 do
        {program
         |> set_noun_and_verb(noun, verb)
         |> Intcode.init()
         |> Intcode.run()
         |> Intcode.memory()
         |> Map.get(0), noun, verb}
      end

    {_, noun, verb} = Enum.find(results, fn {value, _, _} -> value == 19_690_720 end)

    noun * 100 + verb
  end

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp set_noun_and_verb(memory, noun, verb) do
    memory
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
  end
end
