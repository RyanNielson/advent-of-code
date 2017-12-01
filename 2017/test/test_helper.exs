ExUnit.start()

defmodule AdventOfCode2017.TestHelper do
  def input(path) do
    File.read!(path)
    |> String.trim
  end
end