defmodule Day07 do
  def part1(input) do
    input
    |> parse()
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def part2(input) do
    sizes = parse(input)
    required = 30_000_000 - (70_000_000 - Enum.max(sizes))

    sizes
    |> Enum.filter(&(&1 >= required))
    |> Enum.min()
  end

  defp handle_line("$ cd /", {_, sizes}), do: {[], sizes}
  defp handle_line("$ cd ..", {[_ | tail], sizes}), do: {tail, sizes}
  defp handle_line("$ cd " <> dir, {path, sizes}), do: {[dir | path], sizes}
  defp handle_line("$ ls", {path, sizes}), do: {path, sizes}
  defp handle_line("dir " <> _, {path, sizes}), do: {path, sizes}

  defp handle_line(line, {path, sizes}) do
    [size, _] = String.split(line)
    {path, update_sizes(path, sizes, String.to_integer(size))}
  end

  defp update_sizes([], sizes, size) do
    Map.update(sizes, "", size, fn current_size -> current_size + size end)
  end

  defp update_sizes([_ | path] = whole, sizes, size) do
    new_sizes = Map.update(sizes, Enum.join(whole, "/"), size, fn s -> s + size end)
    update_sizes(path, new_sizes, size)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], Map.new()}, &handle_line/2)
    |> elem(1)
    |> Map.values()
  end
end
