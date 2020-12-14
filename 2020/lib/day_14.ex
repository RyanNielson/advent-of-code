defmodule Day14 do
  def part1(input) do
    input
    |> parse()
    |> Enum.reduce(%{mem: %{}, mask: ""}, fn inst, state ->
      instruction(inst, state)
    end)
    |> Map.get(:mem)
    |> Map.values()
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.reduce(%{mem: %{}, mask: ""}, fn inst, state ->
      instruction_2(inst, state)
    end)
    |> Map.get(:mem)
    |> Map.values()
    |> Enum.sum()
  end

  defp instruction({"mask", value}, state) do
    Map.put(state, :mask, value)
  end

  defp instruction({"mem", address, value}, %{mask: mask, mem: mem} = state) do
    new_value =
      value
      |> Integer.digits(2)
      |> Enum.map(&Integer.to_string/1)
      |> List.to_string()
      |> String.pad_leading(36, "0")
      |> String.split("", trim: true)
      |> Enum.zip(String.split(mask, "", trim: true))
      |> Enum.map(fn
        {val, "X"} ->
          val

        {_, mask_val} ->
          mask_val
      end)
      |> Enum.map(&String.to_integer/1)
      |> Integer.undigits(2)

    state
    |> Map.put(:mem, Map.put(mem, address, new_value))
  end

  defp instruction_2({"mask", value}, state) do
    Map.put(state, :mask, value)
  end

  # TODO: This doesn't work when more than 2 Xs
  defp instruction_2({"mem", address, value}, %{mask: mask, mem: mem} = state) do
    new_address =
      address
      |> Integer.digits(2)
      |> Enum.map(&Integer.to_string/1)
      |> List.to_string()
      |> String.pad_leading(36, "0")
      |> String.split("", trim: true)
      |> Enum.zip(String.split(mask, "", trim: true))
      |> Enum.map(fn
        {add, "0"} ->
          add

        {_, mask_add} ->
          mask_add
      end)
      |> IO.inspect()

    # |> Enum.with_index()

    floating_indices =
      new_address
      |> Enum.with_index()
      |> Enum.filter(fn {val, _} -> val == "X" end)
      |> Enum.map(&elem(&1, 1))
      |> IO.inspect()

    # product = for i <- floating_indices, j <- floating_indices, k <- ["0", "1"], do: {i, j, k}

    # indices_product = for i <- floating_indices, j <- floating_indices, do: {i, j}

    # IO.inspect(indices_product)
    stuff =
      floating_indices
      |> Enum.flat_map(fn index ->
        for i <- [index], k <- ["0", "1"], do: {i, k}
      end)
      |> IO.inspect()

    # This list is twice as long as it needs to be, but it probably doesn't matter.
    indices_product = for i <- stuff, j <- stuff, elem(i, 0) != elem(j, 0), do: {i, j}
    IO.inspect(indices_product)

    indices_product
    |> Enum.map(fn indices ->
      IO.inspect(indices)
    end)

    # product = for i <- floating_indices, j <- floating_indices, k <- ["0", "1"], do: {i, j, k}

    # product
    # |> IO.inspect()

    # |> IO.inspect()
    # |> Enum.reduce({"", []}, fn {bit, i}, {string_so_far, x_pos_list} ->
    #   case bit do
    #     "X" -> {string_so_far <> "0", [35 - i | x_pos_list]}
    #     _ -> {string_so_far <> bit, x_pos_list}
    #   end
    # end)
    # |> IO.inspect()

    #   |> Enum.map(&String.to_integer/1)
    #   |> Integer.undigits(2)

    # state
    # |> Map.put(:mem, Map.put(mem, address, new_value))
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      mask_captures = Regex.run(~r/mask = (.+)/, line, capture: :all_but_first)
      mem_captures = Regex.run(~r/mem\[(\d+)\] = (\d+)/, line, capture: :all_but_first)

      cond do
        mask_captures ->
          {"mask", Enum.at(mask_captures, 0)}

        mem_captures ->
          {
            "mem",
            mem_captures |> Enum.at(0) |> String.to_integer(),
            mem_captures |> Enum.at(1) |> String.to_integer()
          }
      end
    end)
  end
end
