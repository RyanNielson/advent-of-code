ExUnit.start()
defmodule AdventOfCode2018.TestHelper do
  def input(path) do
    File.read!("test/input/#{path}")
    |> String.trim
  end
end