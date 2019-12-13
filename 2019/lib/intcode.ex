defmodule Intcode do
  def init(program, input \\ []) do
    %{
      memory:
        program |> Enum.with_index() |> Enum.into(%{}, fn {value, index} -> {index, value} end),
      ip: 0,
      input: input,
      output: [],
      base: 0,
      halted: false
    }
  end

  # TODO: Perhaps add a halted status so I can tell the difference between halted and waiting for input.
  def run(state, input \\ []) do
    state = add_input(state, input)
    [code, param1, param2, param3] = fetch_params(state)

    case code do
      1 -> arithmetic(state, param1, param2, param3, &+/2) |> run()
      2 -> arithmetic(state, param1, param2, param3, &*/2) |> run()
      # 3 -> input(state, param1) |> run()
      3 -> input(state, param1)
      4 -> output(state, param1) |> run()
      5 -> jump(state, param1, param2, &(&1 != 0)) |> run()
      6 -> jump(state, param1, param2, &(&1 == 0)) |> run()
      7 -> compare(state, param1, param2, param3, &</2) |> run()
      8 -> compare(state, param1, param2, param3, &==/2) |> run()
      9 -> adjust_relative_base(state, param1) |> run()
      99 -> halt(state)
    end
  end

  defp arithmetic(%{ip: ip} = state, param1, param2, param3, func) do
    value = func.(read(state, param1), read(state, param2))
    %{state | memory: write(state, param3, value), ip: ip + 4}
  end

  defp adjust_relative_base(%{base: base, ip: ip} = state, param1) do
    %{state | base: base + read(state, param1), ip: ip + 2}
  end

  defp jump(%{ip: ip} = state, param1, param2, func) do
    case func.(read(state, param1)) do
      true -> %{state | ip: read(state, param2)}
      false -> %{state | ip: ip + 3}
    end
  end

  defp compare(%{ip: ip} = state, param1, param2, param3, func) do
    value =
      case func.(read(state, param1), read(state, param2)) do
        true -> 1
        false -> 0
      end

    %{state | memory: write(state, param3, value), ip: ip + 4}
  end

  # TODO: If this is called with no input we might want to pause and wait for more.
  defp input(%{ip: ip, input: [value | rest]} = state, param1) do
    %{state | input: rest, memory: write(state, param1, value), ip: ip + 2} |> run()
  end

  defp input(%{input: []} = state, _), do: state

  defp output(%{ip: ip, output: output} = state, param1) do
    value = read(state, param1)
    # %{state | output: [value | output], ip: ip + 2}
    %{state | output: output ++ [value], ip: ip + 2}
  end

  # TODO: Should these just return the whole state to keep things simple?
  defp write(%{memory: memory, base: base}, {location, :r}, value) do
    Map.put(memory, location + base, value)
  end

  defp write(%{memory: memory}, {location, _}, value) do
    Map.put(memory, location, value)
  end

  defp read(%{memory: memory}, {location, :p}) do
    Map.get(memory, location, 0)
  end

  defp read(%{memory: memory, base: base}, {location, :r}) do
    Map.get(memory, location + base, 0)
  end

  defp read(_state, {location, :i}) do
    location
  end

  defp halt(state) do
    IO.inspect("HALTED")
    %{state | halted: true}
  end

  # This is gross but it works, maybe clean it up later.
  defp fetch_params(%{memory: memory, ip: ip}) do
    codes = Map.get(memory, ip, 0)

    {modes, code} =
      codes
      |> Integer.to_string()
      |> String.pad_leading(5, "0")
      |> String.split_at(-2)

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
  end

  # This may be slow, perhaps we should look into using a queue instead.
  defp add_input(%{input: input} = state, new_input) do
    %{state | input: input ++ new_input}
  end

  def memory(%{memory: memory}), do: memory
  def output(%{output: output}), do: output

  def clear_output(state), do: %{state | output: []}
end
