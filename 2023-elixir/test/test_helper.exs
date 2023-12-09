ExUnit.start()

defmodule TestHelper do
  def input(file, trim? \\ true) do
    input =
      file
      |> Path.absname("test/input")
      |> File.read!()

    if trim?, do: String.trim(input), else: input
  end
end
