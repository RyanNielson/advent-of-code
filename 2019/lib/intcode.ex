defmodule Intcode do
  def init(program, input \\ []) do
    %{
      memory:
        program |> Enum.with_index() |> Enum.into(%{}, fn {value, index} -> {index, value} end),
      ip: 0,
      input: input,
      output: [],
      base: 0
    }
  end

  def run(state) do
    [code, param1, param2, param3] = fetch_params(state)

    case code do
      1 -> add(state, param1, param2, param3) |> run()
      2 -> multiply(state, param1, param2, param3) |> run()
      3 -> input(state, param1) |> run()
      4 -> output(state, param1) |> run()
      5 -> jump(state, param1, param2, &(&1 != 0)) |> run()
      6 -> jump(state, param1, param2, &(&1 == 0)) |> run()
      7 -> compare(state, param1, param2, param3, &</2) |> run()
      8 -> compare(state, param1, param2, param3, &==/2) |> run()
      99 -> halt(state)
    end
  end

  defp jump(%{ip: ip} = state, param1, param2, func) do
    case func.(read(state, param1)) do
      true -> %{state | ip: read(state, param2)}
      false -> %{state | ip: ip + 3}
    end
  end

  # # TODO: These can be combined by just passing in a function to compare like &(&1 != 0) and &(&1 == 0)
  # defp jump_true(%{ip: ip} = state, param1, param2) do
  #   case read(state, param1) do
  #     0 -> %{state | ip: ip + 3}
  #     _ -> %{state | ip: read(state, param2)}
  #   end
  # end

  # defp jump_false(%{ip: ip} = state, param1, param2) do
  #   case read(state, param1) do
  #     0 -> %{state | ip: read(state, param2)}
  #     _ -> %{state | ip: ip + 3}
  #   end
  # end

  defp compare(%{ip: ip} = state, param1, param2, param3, func) do
    value =
      case func.(read(state, param1), read(state, param2)) do
        true -> 1
        false -> 0
      end

    %{state | memory: write(state, param3, value), ip: ip + 4}
  end

  # # Can simplify these by doing the same as the jump
  # defp less_than(%{ip: ip} = state, param1, param2, param3) do
  #   value =
  #     case read(state, param1) < read(state, param2) do
  #       true -> 1
  #       false -> 0
  #     end

  #   %{state | memory: write(state, param3, value), ip: ip + 4}
  # end

  # defp equals(%{ip: ip} = state, param1, param2, param3) do
  #   value =
  #     case read(state, param1) == read(state, param2) do
  #       true -> 1
  #       false -> 0
  #     end

  #   %{state | memory: write(state, param3, value), ip: ip + 4}
  # end

  # defp compare_instruction(
  #        {memory, input, output},
  #        addr1,
  #        addr2,
  #        location,
  #        [mode1, mode2, _],
  #        pointer,
  #        func
  #      ) do
  #   first = get_value(memory, mode1, addr1)
  #   second = get_value(memory, mode2, addr2)

  #   memory =
  #     case func.(first, second) do
  #       true -> List.replace_at(memory, location, 1)
  #       false -> List.replace_at(memory, location, 0)
  #     end

  #   run({memory, input, output}, pointer + 4)
  # end

  defp add(%{ip: ip} = state, param1, param2, param3) do
    %{state | memory: write(state, param3, read(state, param1) + read(state, param2)), ip: ip + 4}
  end

  defp multiply(%{ip: ip} = state, param1, param2, param3) do
    %{state | memory: write(state, param3, read(state, param1) * read(state, param2)), ip: ip + 4}
  end

  defp input(%{ip: ip, input: [value | rest]} = state, param1) do
    %{state | input: rest, memory: write(state, param1, value), ip: ip + 2}
  end

  defp output(%{ip: ip, output: output} = state, param1) do
    value = read(state, param1)
    %{state | output: [value | output], ip: ip + 2}

    # run({List.replace_at(memory, location, input), input, output}, pointer + 2)
  end

  # defp output_instruction({memory, input, output}, location, [mode1, _, _], pointer) do
  #   val = get_value(memory, mode1, location)

  #   run({memory, input, [val | output]}, pointer + 2)
  # end

  # TODO: Should these just return the whole state to keep things simple?
  defp write(%{memory: memory}, {location, _}, value) do
    Map.put(memory, location, value)
  end

  defp read(%{memory: memory}, {location, :p}) do
    Map.get(memory, location, 0)
  end

  defp read(_state, {location, :i}) do
    location
  end

  # defp instruction(memory, addr_1, addr_2, destination, func) do
  #   first = Enum.at(memory, addr_1)
  #   second = Enum.at(memory, addr_2)
  #   List.replace_at(memory, destination, func.(first, second))
  # end

  defp halt(state) do
    state
  end

  defp fetch_params(%{memory: memory, ip: ip}) do
    codes = Map.get(memory, ip, 0)

    {modes, code} =
      codes
      |> Integer.to_string()
      |> String.pad_leading(5, "0")
      |> String.split_at(-2)

    # IO.inspect(memory)
    # IO.inspect(codes)
    # IO.inspect(modes)
    # IO.inspect(code)

    params =
      modes
      |> String.graphemes()
      |> Enum.map(fn
        "0" -> :p
        "1" -> :i
        "2" -> :r
      end)
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.map(fn {mode, i} ->
        {Map.get(memory, ip + i, 0), mode}
      end)

    [String.to_integer(code) | params]

    # (ip + 1)..(ip + 3)
    # |> Enum.map(fn position ->
    #   Map.get(memory, position, 0)
    # end)

    # [code]

    #   modes =
    #     modes
    #     |> String.graphemes()
    #     |> Enum.map(fn
    #       "0" -> :p
    #       "1" -> :i
    #     end)
    #     |> Enum.reverse()
  end

  def memory(%{memory: memory}), do: memory
  def output(%{output: output}), do: output

  # {code, modes} = code_and_modes(codes)
  # defp code_and_modes(codes) do
  #   {modes, code} =
  #     codes
  #     |> Integer.to_string()
  #     |> String.pad_leading(5, "0")
  #     |> String.split_at(-2)

  #   modes =
  #     modes
  #     |> String.graphemes()
  #     |> Enum.map(fn
  #       "0" -> :p
  #       "1" -> :i
  #     end)
  #     |> Enum.reverse()

  #   {code, modes}
  # end
end
