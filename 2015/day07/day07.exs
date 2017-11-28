defmodule Day07 do
  @input "day07.input"

  @bitwise_operations %{
    "NOT"    => &:erlang.bnot/1,
    "AND"    => &:erlang.band/2,
    "OR"     => &:erlang.bor/2,
    "LSHIFT" => &:erlang.bsl/2,
    "RSHIFT" => &:erlang.bsr/2
  }

  def what_is_provided_to(wire) do

  end

  defp parse do
    # @input
    # |> File.read!
    # |> String.split("\n", trim: true)
  end
end

IO.puts Day07.what_is_provided_to("a")
