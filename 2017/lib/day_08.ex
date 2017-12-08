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
    |> fill_registers_get_history()
    |> highest_ever()
  end

  def parse(input) do
    input
    |> String.split((~r/\r\n|\r|\n/), trim: true)
    |> Enum.map(&String.split()/1)
    |> Enum.map(fn ([reg, op, amount, _, cond_reg, condition, num]) ->
      [reg, op, String.to_integer(amount), cond_reg, condition, String.to_integer(num)]
    end)
  end

  def init_registers(instructions) do
    instructions
    |> Enum.reduce(%{}, fn([name | _], registers) ->
      Map.put(registers, name, 0)
    end)
  end

  def fill_registers(instructions) do
    instructions
    |> Enum.reduce(init_registers(instructions), fn ([name, op, amount | condition], registers) ->
      case (condition(registers, condition)) do
        true -> handle_operation(registers, name, op, amount)
        false -> registers
      end
    end)
  end

  def fill_registers_get_history(instructions) do
    instructions
    |> Enum.map_reduce(init_registers(instructions), fn ([name, op, amount | condition], registers) ->
      case (condition(registers, condition)) do
        true ->
          value = new_value(registers, name, op, amount)
          {value, handle_operation(registers, name, op, amount)}
        false ->
          {registers[name], registers}
      end
    end)
  end

  def highest_value(registers) do
    registers
    |> Map.values()
    |> Enum.max()
  end

  def highest_ever({history, _}) do
    history
    |> Enum.max()
  end

  def condition(registers, [register, ">", amount]), do: registers[register] > amount
  def condition(registers, [register, "<", amount]), do: registers[register] < amount
  def condition(registers, [register, ">=", amount]), do: registers[register] >= amount
  def condition(registers, [register, "<=", amount]), do: registers[register] <= amount
  def condition(registers, [register, "==", amount]), do: registers[register] == amount
  def condition(registers, [register, "!=", amount]), do: registers[register] != amount

  def handle_operation(registers, register, "inc", amount), do: Map.update(registers, register, 0, &(&1 + amount))
  def handle_operation(registers, register, "dec", amount), do: Map.update(registers, register, 0, &(&1 - amount))

  def new_value(registers, register, "inc", amount), do: registers[register] + amount
  def new_value(registers, register, "dec", amount), do: registers[register] - amount
end