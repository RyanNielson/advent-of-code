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
    # program =
    #   input
    #   |> parse()

    # # Input should be array?
    # {_, _, output} =
    #   {program, val, []}
    #   |> run(0)

    # List.first(output)

    input
    |> parse()
    |> Intcode.init([val])
    |> Intcode.run()
    |> Intcode.output()
    |> List.first()
  end

  # @doc """
  # ## Examples

  #   iex> Helpers.input("day_05") |> Day05.part1()
  #   5_821_753
  # """
  # def part1(input) do
  #   program =
  #     input
  #     |> parse()

  #   {_, _, output} =
  #     {program, 1, []}
  #     |> run(0)

  #   List.first(output)
  # end

  # @doc """
  # ## Examples
  #   # iex> Day05.part2("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", 0)
  #   # 0
  #   # iex> Day05.part2("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", 11)
  #   # 1
  #   # iex> Day05.part2("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", 0)
  #   # 0
  #   # iex> Day05.part2("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", 55)
  #   # 1
  #   # iex> Day05.part2("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99", 6)
  #   # 999
  #   # iex> Day05.part2("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99", 8)
  #   # 1000
  #   # iex> Day05.part2("3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99", 23)
  #   # 1001
  #   # iex> Helpers.input("day_05") |> Day05.part2(5)
  #   # 11_956_381
  # """
  # def part2(input, val) do
  #   program =
  #     input
  #     |> parse()

  #   # Input should be array?
  #   {_, _, output} =
  #     {program, val, []}
  #     |> run(0)

  #   List.first(output)
  # end

  defp run({memory, _input, _output} = state, pointer) do
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

  defp input_instruction({memory, input, output}, location, pointer) do
    run({List.replace_at(memory, location, input), input, output}, pointer + 2)
  end

  defp output_instruction({memory, input, output}, location, [mode1, _, _], pointer) do
    val = get_value(memory, mode1, location)

    run({memory, input, [val | output]}, pointer + 2)
  end

  defp instruction(
         {memory, input, output},
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

    run({memory, input, output}, pointer + 4)
  end

  defp jump_instruction(
         {memory, input, output},
         addr1,
         addr2,
         [mode1, mode2, _],
         pointer,
         func
       ) do
    first = get_value(memory, mode1, addr1)
    second = get_value(memory, mode2, addr2)

    case func.(first) do
      true -> run({memory, input, output}, second)
      false -> run({memory, input, output}, pointer + 3)
    end
  end

  defp compare_instruction(
         {memory, input, output},
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

    run({memory, input, output}, pointer + 4)
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
