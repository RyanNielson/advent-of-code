defmodule AdventOfCode2017.Day08 do
  def part1(input) do
    input
    |> parse()
    |> fill_registers()
    |> highest_value()
  end

  def part2(input) do
    input
    |> parse()
    |> fill_registers()
    |> highest_value_ever()
  end

  defp parse(input) do
    input
    |> String.split((~r/\r\n|\r|\n/), trim: true)
    |> Enum.map(&String.split()/1)
    |> Enum.map(fn ([reg, op, amount, _, cond_reg, condition, num]) ->
      [reg, op, String.to_integer(amount), cond_reg, condition, String.to_integer(num)]
    end)
  end

  defp init_registers(instructions), do: Map.new(instructions, fn [name | _] -> {name, 0} end)

  defp fill_registers(instructions),  do: Enum.map_reduce(instructions, init_registers(instructions), &modify_register/2)

  defp modify_register([name, op, amount | condition], registers) do
    if condition(registers, condition) do
      new_value = new_value(registers, name, op, amount)
      {new_value, Map.put(registers, name, new_value)}
    else
      {registers[name], registers}
    end
  end

  defp highest_value({_, registers}), do: registers |> Map.values() |> Enum.max()

  defp highest_value_ever({history, _}), do: Enum.max(history)

  defp condition(registers, [register, ">", amount]), do: registers[register] > amount
  defp condition(registers, [register, "<", amount]), do: registers[register] < amount
  defp condition(registers, [register, ">=", amount]), do: registers[register] >= amount
  defp condition(registers, [register, "<=", amount]), do: registers[register] <= amount
  defp condition(registers, [register, "==", amount]), do: registers[register] == amount
  defp condition(registers, [register, "!=", amount]), do: registers[register] != amount

  defp new_value(registers, register, "inc", amount), do: registers[register] + amount
  defp new_value(registers, register, "dec", amount), do: registers[register] - amount
end