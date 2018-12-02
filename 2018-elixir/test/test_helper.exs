ExUnit.start()

defmodule AdventOfCode2018.TestHelper do
  def input(path) do
    File.read!(path)
    |> String.trim
  end
end