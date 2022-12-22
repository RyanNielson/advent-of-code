defmodule Day21 do
  def part1(input) do
    monkeys =
      input
      |> parse()

    yell(monkeys, Map.get(monkeys, :root))
  end

  def part2(input) do
    monkeys =
      input
      |> parse()
      |> Map.update!(:root, fn {a, b, job} ->
        {a, b, String.replace(job, "+", "=")}
      end)
      |> Map.put(:humn, "?")

    equation(monkeys, Map.get(monkeys, :root))
    |> String.slice(1..-2)
    |> solve()
  end

  defp equation(monkeys, {a, b, job}) do
    job
    |> String.replace(Atom.to_string(a), "#{equation(monkeys, Map.get(monkeys, a))}")
    |> String.replace(Atom.to_string(b), "#{equation(monkeys, Map.get(monkeys, b))}")
    |> then(fn stuff -> "(#{stuff})" end)
  end

  defp equation(_, a), do: a

  defp solve(equation) do
    [left, right] = String.split(equation, " = ")

    {to_solve, value} =
      case String.contains?(left, "?") do
        true -> {left, Code.eval_string(right) |> elem(0)}
        false -> {right, Code.eval_string(left) |> elem(0)}
      end

    to_solve
    |> simplify()
    |> determine(floor(value))
  end

  defp simplify(equation) do
    Stream.iterate(0, &(&1 + 1))
    |> Enum.reduce_while(equation, fn _, equation ->
      case Regex.run(~r/(\d+ [\/\*\+\-] \d+)/, equation, capture: :all_but_first) do
        nil ->
          {:halt, equation}

        [solvable_piece] ->
          new_equation =
            String.replace(
              equation,
              "(#{solvable_piece})",
              Code.eval_string(solvable_piece) |> elem(0) |> floor() |> to_string()
            )

          {:cont, String.trim(new_equation)}
      end
    end)
  end

  defp determine("?", value), do: value

  # defp fancy_stuff(left, right)

  # NEED TO FLIP TO_SOLVE AND VALUE DEPENDING ON POSITION OF ? COMPARED TO CURRENT OP
  defp determine(to_solve, value) when is_integer(value) do
    to_solve =
      to_solve
      |> String.slice(1..-2)

    {number, operation, new_equation, _flip} =
      cond do
        String.ends_with?(to_solve, ")") ->
          [operation, equation] =
            to_solve
            |> String.split(~r/^\d+ [\/\+\-\*]/, trim: true, include_captures: true)

          [number, op] = String.split(operation, " ")
          {String.to_integer(number), op, String.trim(equation), true}

        String.starts_with?(to_solve, "(") ->
          [equation, operation] =
            to_solve
            |> String.split(~r/[\/\+\-\*] \d+$/, trim: true, include_captures: true)

          [op, number] = String.split(operation, " ")
          {String.to_integer(number), op, String.trim(equation), false}

        true ->
          # ONLY WORKS FOR TWO EXAMPLES, NEED TO CHECK FOR ? PLACEMENT FOR GENERAL USE.
          [equation, op, number] = String.split(to_solve)
          {String.to_integer(number), op, String.trim(equation), false}
      end

    # {to_solve, value} =
    # if flip do
    #   {to_solve, value} = {value, to_solve}
    # else
    #   {to_solve, value}
    # end

    # TODO: # If ? is to the right of what we're checking, you have to move ?'s equation to the other side to the other equation.
    new_value =
      case operation do
        # If ? is to the right of what we're checking, you have to move ?'s equation to the other side to the other equation.
        "/" ->
          value * number

        # && flip ->
        "*" ->
          div(value, number)

        "+" ->
          value - number

        # THIS IS DIFFERENT AS WELL.
        "-" ->
          value + number
      end

    determine(new_equation, new_value)
  end

  defp determine(to_solve, value) do
    IO.inspect("k")
    determine(value, to_solve)
  end

  defp yell(_, a) when is_integer(a), do: a

  defp yell(monkeys, {a, b, job}) do
    Code.eval_string(job, [
      {a, yell(monkeys, Map.get(monkeys, a))},
      {b, yell(monkeys, Map.get(monkeys, b))}
    ])
    |> elem(0)
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.into(%{}, fn line ->
      [name, job] = String.split(line, ": ")

      job =
        case Integer.parse(job) do
          :error ->
            [a, _, b] = job |> String.split(" ") |> Enum.map(&String.to_atom/1)
            {a, b, job}

          {number, _} ->
            number
        end

      {String.to_atom(name), job}
    end)
  end
end
