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
      |> parse()

    permutations([0, 1, 2, 3, 4])
    |> Enum.map(fn phases ->
      phases
      |> Enum.reduce(0, fn phase, signal ->
        {_, _, output} = run({program, [phase, signal], []}, 0)

        output |> List.first()
      end)
    end)
    |> Enum.max()
  end

  # TODO: Output could probably just be a single value instead of a list.
  defp run({memory, _inputs, _output} = state, pointer) do
    [codes, addr1, addr2, location] = fetch_params(memory, pointer)

    {code, modes} = code_and_modes(codes)

    case String.to_integer(code) do
      1 -> instruction(state, addr1, addr2, location, &+/2, modes, pointer)
      2 -> instruction(state, addr1, addr2, location, &*/2, modes, pointer)
      3 -> input_instruction(state, addr1, pointer)
      4 -> output_instruction(state, addr1, modes, pointer)
      5 -> jump_instruction(state, addr1, addr2, modes, pointer, &(&1 != 0))
      6 -> jump_instruction(state, addr1, addr2, modes, pointer, &(&1 == 0))
      7 -> compare_instruction(state, addr1, addr2, location, modes, pointer, &</2)
      8 -> compare_instruction(state, addr1, addr2, location, modes, pointer, &==/2)
      99 -> state
    end
  end

  def permutations([]), do: [[]]

  def permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])

  defp code_and_modes(codes) do
    {modes, code} =
      codes
      |> Integer.to_string()
      |> String.pad_leading(5, "0")
      |> String.split_at(-2)

    modes =
      modes
      |> String.graphemes()
      |> Enum.map(fn
        "0" -> :p
        "1" -> :i
      end)
      |> Enum.reverse()

    {code, modes}
  end

  defp input_instruction({memory, [input | rest], output}, location, pointer) do
    run({List.replace_at(memory, location, input), rest, output}, pointer + 2)
  end

  defp output_instruction({memory, inputs, output}, location, [mode1, _, _], pointer) do
    val = get_value(memory, mode1, location)

    run({memory, inputs, [val | output]}, pointer + 2)
  end

  defp instruction(
         {memory, inputs, output},
         addr1,
         addr2,
         location,
         func,
         [mode1, mode2, _mode3],
         pointer
       ) do
    first = get_value(memory, mode1, addr1)
    second = get_value(memory, mode2, addr2)

    memory = List.replace_at(memory, location, func.(first, second))

    run({memory, inputs, output}, pointer + 4)
  end

  defp jump_instruction(
         {memory, inputs, output},
         addr1,
         addr2,
         [mode1, mode2, _],
         pointer,
         func
       ) do
    first = get_value(memory, mode1, addr1)
    second = get_value(memory, mode2, addr2)

    case func.(first) do
      true -> run({memory, inputs, output}, second)
      false -> run({memory, inputs, output}, pointer + 3)
    end
  end

  defp compare_instruction(
         {memory, inputs, output},
         addr1,
         addr2,
         location,
         [mode1, mode2, _],
         pointer,
         func
       ) do
    first = get_value(memory, mode1, addr1)
    second = get_value(memory, mode2, addr2)

    memory =
      case func.(first, second) do
        true -> List.replace_at(memory, location, 1)
        false -> List.replace_at(memory, location, 0)
      end

    run({memory, inputs, output}, pointer + 4)
  end

  defp get_value(memory, :p, location) do
    Enum.at(memory, location)
  end

  defp get_value(_memory, :i, location) do
    location
  end

  defp fetch_params(memory, pointer) do
    pointer..(pointer + 3) |> Enum.map(&Enum.at(memory, &1))
  end

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
