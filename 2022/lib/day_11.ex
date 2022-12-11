defmodule Day11 do
  def part1(input) do
    starting_monkeys = parse(input)

    0..19
    |> Enum.reduce(starting_monkeys, fn round, monkeys ->
      0..(Enum.count(monkeys) - 1)
      |> Enum.reduce(monkeys, fn i, monkeys ->
        {items, operation, test, if_true, if_false, _} = Enum.at(monkeys, i)

        items
        |> Enum.map(fn item ->
          {new, _} = Code.eval_string(operation, old: item)
          new = floor(new / 3)
          throw_to = if rem(new, test) == 0, do: if_true, else: if_false
          {new, i, throw_to}
        end)
        |> Enum.reduce(monkeys, fn {item, from, to}, monkeys ->
          monkeys
          |> List.update_at(from, fn {items, operation, test, if_true, if_false, inspections} ->
            {[], operation, test, if_true, if_false, inspections + Enum.count(items)}
          end)
          |> List.update_at(to, fn {items, operation, test, if_true, if_false, inspections} ->
            {items ++ [item], operation, test, if_true, if_false, inspections}
          end)
        end)
      end)
    end)
    |> Enum.map(&elem(&1, 5))
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()

    # |> IO.inspect(charlists: :as_list)
  end

  # defp

  def part2(input) do
    input
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(fn monkey ->
      [_, starting_items, operation, test, if_true, if_false] =
        String.split(monkey, "\n", trim: true)
        |> Enum.map(&String.trim/1)

      starting_items =
        starting_items
        |> String.split("Starting items: ", trim: true)
        |> List.first()
        |> String.split(",", trim: true)
        |> Enum.map(&String.trim/1)
        |> Enum.map(&String.to_integer/1)

      operation = operation |> String.split("Operation: ") |> List.last()

      test =
        test
        |> String.split("Test: divisible by ", trim: true)
        |> List.last()
        |> String.to_integer()

      if_true =
        if_true |> String.split("If true: throw to monkey ") |> List.last() |> String.to_integer()

      if_false =
        if_false
        |> String.split("If false: throw to monkey ")
        |> List.last()
        |> String.to_integer()

      {starting_items, operation, test, if_true, if_false, 0}
    end)
  end
end
