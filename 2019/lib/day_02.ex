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
    |> run(0)
    |> List.first()
  end

  @doc """
  ## Examples

    iex> Helpers.input("day_02") |> Day02.part2()
    3376
  """
  def part2(input) do
    memory = input |> parse()

    results =
      for noun <- 0..99, verb <- 0..99 do
        {memory |> set_noun_and_verb(noun, verb) |> run(0) |> List.first(), noun, verb}
      end

    {_, noun, verb} = Enum.find(results, fn {value, _, _} -> value == 19_690_720 end)

    noun * 100 + verb
  end

  @doc """
  An async version of part 2 that completes about 40% faster using Tasks.

    ## Examples

    iex> Helpers.input("day_02") |> Day02.part2_async()
    3376
  """
  def part2_async(input) do
    memory = input |> parse()

    results =
      for noun <- 0..99, verb <- 0..99 do
        Task.async(fn ->
          {memory |> set_noun_and_verb(noun, verb) |> run(0) |> List.first(), noun, verb}
        end)
      end

    {_, noun, verb} =
      results
      |> Enum.map(&Task.await/1)
      |> Enum.find(results, fn {value, _, _} -> value == 19_690_720 end)

    noun * 100 + verb
  end

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp run(memory, pointer) do
    [code, addr_1, addr_2, destination] = fetch_params(memory, pointer)

    # TODO: Can probably remove this duplication.
    case code do
      1 -> instruction(memory, addr_1, addr_2, destination, &+/2) |> run(pointer + 4)
      2 -> instruction(memory, addr_1, addr_2, destination, &*/2) |> run(pointer + 4)
      99 -> memory
    end
  end

  defp fetch_params(memory, pointer) do
    pointer..(pointer + 3) |> Enum.map(&Enum.at(memory, &1))
  end

  defp set_noun_and_verb(memory, noun, verb) do
    memory
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
  end

  defp instruction(memory, addr_1, addr_2, destination, func) do
    first = Enum.at(memory, addr_1)
    second = Enum.at(memory, addr_2)
    List.replace_at(memory, destination, func.(first, second))
  end
end
