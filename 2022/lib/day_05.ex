defmodule Day05 do
  def part1(input) do
    rearrange(input)
  end

  def part2(input) do
    rearrange(input, false)
  end

  defp rearrange(input, reverse \\ true) do
    {starting_stacks, instructions} =
      input
      |> parse()

    instructions
    |> Enum.reduce(starting_stacks, fn {num, from, to}, stacks ->
      from_index = from - 1
      to_index = to - 1
      stack = elem(stacks, from_index)
      {crates_to_move, new_from_stack} = Enum.split(stack, num)
      crates_to_move = if reverse, do: Enum.reverse(crates_to_move), else: crates_to_move
      new_to_stack = crates_to_move ++ elem(stacks, to_index)

      stacks
      |> put_elem(from_index, new_from_stack)
      |> put_elem(to_index, new_to_stack)
    end)
    |> Tuple.to_list()
    |> Enum.map(&List.first/1)
    |> Enum.join()
  end

  defp parse(input) do
    [stacks_input, instructions_input] = String.split(input, "\n\n", trim: true)
    {parse_stacks(stacks_input), parse_instructions(instructions_input)}
  end

  def parse_stacks(stacks_input) do
    {starting_stacks, _} =
      stacks_input
      |> String.split("\n", trim: true)
      |> Enum.split(-1)

    starting_stacks
    |> Enum.map(fn line ->
      ~r/(\s{4}|\s{5}|\S{3})/
      |> Regex.scan(line, capture: :all_but_first)
      |> List.flatten()
      |> Enum.map(fn crate ->
        case crate do
          "   " -> nil
          "    " -> nil
          c -> String.replace(c, ["[", "]"], "")
        end
      end)
    end)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn stack ->
      Enum.reject(stack, &is_nil/1)
    end)
    |> List.to_tuple()
  end

  defp parse_instructions(instructions_input) do
    instructions_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      ~r/move (\d+) from (\d+) to (\d+)/
      |> Regex.run(line, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
  end
end
