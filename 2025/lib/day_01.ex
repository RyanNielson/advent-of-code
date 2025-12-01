defmodule Day01 do
  def part_1(input) do
    input
    |> String.split()
    |> Enum.map_reduce(50, fn rotation, pointing_at ->
      new_pointing_at = (pointing_at + rotation_amount(rotation)) |> Integer.mod(100)
      {new_pointing_at, new_pointing_at}
    end)
    |> elem(0)
    |> Enum.count(fn x -> x == 0 end)
  end

  def part_2(input) do
    input
    |> String.split()
    |> Enum.map_reduce(50, fn rotation, pointing_at ->
      rotation_amount = rotation_amount(rotation)
      complete_rotations = div(rotation_amount, 100) |> abs()
      new_pointing_at = pointing_at + rem(rotation_amount, 100)
      corrected_pointing_at = new_pointing_at |> Integer.mod(100)

      cond do
        corrected_pointing_at == 0 or
            (pointing_at != 0 and (new_pointing_at < 0 or new_pointing_at > 99)) ->
          {1 + complete_rotations, corrected_pointing_at}

        true ->
          {complete_rotations, corrected_pointing_at}
      end
    end)
    |> elem(0)
    |> Enum.sum()
  end

  defp rotation_amount("L" <> amount_str), do: -String.to_integer(amount_str)
  defp rotation_amount("R" <> amount_str), do: String.to_integer(amount_str)
end
