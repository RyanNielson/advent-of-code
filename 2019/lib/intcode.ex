defmodule Intcode do
  def init(program) do
    %{
      memory:
        program |> Enum.with_index() |> Enum.into(%{}, fn {value, index} -> {index, value} end),
      ip: 0,
      input: [],
      output: [],
      base: 0
    }
  end

  # def run(state) do
  # end

  def run(state) do
    [code, param1, param2, param3] = fetch_params(state)
    # IO.inspect(code)
    # IO.inspect(param1)
    # IO.inspect(param2)
    # IO.inspect(param3)
    # # TODO: Can probably remove this duplication.
    case code do
      1 -> add(state, param1, param2, param3) |> run()
      2 -> multiply(state, param1, param2, param3) |> run()
      99 -> halt(state)
    end
  end

  defp add(%{ip: ip} = state, param1, param2, param3) do
    %{state | memory: write(state, param3, read(state, param1) + read(state, param2)), ip: ip + 4}
  end

  defp multiply(%{ip: ip} = state, param1, param2, param3) do
    %{state | memory: write(state, param3, read(state, param1) * read(state, param2)), ip: ip + 4}
  end

  defp write(%{memory: memory}, location, value) do
    Map.put(memory, location, value)
  end

  defp read(%{memory: memory}, location) do
    Map.get(memory, location, 0)
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
    ip..(ip + 3) |> Enum.map(&Map.get(memory, &1))
  end

  def memory(%{memory: memory}), do: memory

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
