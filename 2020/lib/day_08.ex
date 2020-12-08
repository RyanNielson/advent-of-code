defmodule Day08 do
  def part1(input) do
    input
    |> parse()
    |> initialize_memory()
    |> run()
    |> accumulator()
  end

  def part2(input) do
    input
    |> parse()
    |> build_instruction_lists()
    |> Enum.map(&initialize_memory/1)
    |> Enum.map(&run/1)
    |> Enum.find(&exited?/1)
    |> accumulator()
  end

  defp build_instruction_lists(instructions) do
    instructions
    |> Enum.with_index()
    |> Enum.map(fn {{operation, argument}, index} ->
      case operation do
        "jmp" -> List.replace_at(instructions, index, {"nop", argument})
        "nop" -> List.replace_at(instructions, index, {"jmp", argument})
        _ -> instructions
      end
    end)
    |> Enum.uniq()
  end

  defp run({_, ip, instructions, executed_instructions} = memory) do
    cond do
      ip >= Enum.count(instructions) ->
        {memory, true}

      MapSet.member?(executed_instructions, ip) ->
        {memory, false}

      true ->
        new_memory = instruction(memory, Enum.at(instructions, ip))
        run(new_memory)
    end
  end

  defp accumulator({{acc, _, _, _}, _}) do
    acc
  end

  defp exited?({_, exited}) do
    exited
  end

  # TODO: Can probably extract the mapset stuff.
  defp instruction({acc, ip, instructions, executed_instructions}, {"acc", argument}) do
    {acc + argument, ip + 1, instructions, MapSet.put(executed_instructions, ip)}
  end

  defp instruction({acc, ip, instructions, executed_instructions}, {"jmp", argument}) do
    {acc, ip + argument, instructions, MapSet.put(executed_instructions, ip)}
  end

  defp instruction({acc, ip, instructions, executed_instructions}, {"nop", _}) do
    {acc, ip + 1, instructions, MapSet.put(executed_instructions, ip)}
  end

  # { instruction_pointer, accumulator, instructions, executed_instructions}
  defp initialize_memory(instructions) do
    {0, 0, instructions, MapSet.new()}
  end

  defp parse(input) do
    input
    |> Helpers.parse_to_list("\n")
    |> Enum.map(fn instruction ->
      [operation, argument] = String.split(instruction)
      {operation, String.to_integer(argument)}
    end)
  end
end
