defmodule Day13 do
  def reflect(items) do
    reflection_indices =
      items
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.with_index()
      |> Enum.filter(fn {[a, b], _i} -> a == b end)
      |> Enum.map(&elem(&1, 1))

    if Enum.empty?(reflection_indices) do
      {false, nil}
    else
      best_reflection =
        reflection_indices
        |> Enum.filter(fn reflects_across ->
          {half1, half2} = items |> Enum.split(reflects_across + 1)

          perfect_reflection? =
            half1 |> Enum.reverse() |> Enum.zip(half2) |> Enum.all?(fn {a, b} -> a == b end)

          perfect_reflection?
        end)
        |> Enum.max(&>=/2, fn -> nil end)

      {!is_nil(best_reflection), best_reflection}
    end
  end

  def part_1(input) do
    input
    |> parse()
    |> Enum.map(fn {rows, columns} ->
      {rows_perfect?, ri} = reflect(rows)
      {columns_perfect?, ci} = reflect(columns)

      cond do
        rows_perfect? ->
          (ri + 1) * 100

        columns_perfect? ->
          ci + 1
      end
    end)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> parse()
  end

  defp parse(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn pattern ->
      rows =
        pattern
        |> String.split("\n")
        |> Enum.map(&String.graphemes/1)

      columns = rows |> List.zip() |> Enum.map(&Tuple.to_list/1)

      {rows, columns}
    end)
  end
end
