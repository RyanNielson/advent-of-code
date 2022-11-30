defmodule Mix.Tasks.Day do
  use Mix.Task
  import Mix.Generator

  @impl Mix.Task
  def run([day | _]) do
    generate_file("lib/day_#{day}.ex", solution_contents(day))
    generate_file("test/day_#{day}_test.exs", test_contents(day))
    generate_file("test/input/day_#{day}", "")
    generate_file("test/input/day_#{day}_example_1", "")
  end

  defp generate_file(path, contents) do
    if overwrite?(path), do: create_file(path, contents)
  end

  defp solution_contents(day) do
    """
    defmodule Day#{day} do
      def part1(input) do
        input
      end

      def part2(input) do
        input
      end
    end
    """
  end

  defp test_contents(day) do
    """
    defmodule Day#{day}Test do
      use ExUnit.Case

      import TestHelper
      import Day#{day}

      test "part1" do
        assert part1(input("day_#{day}_example_1")) == 123
        assert part1(input("day_#{day}")) == 456
      end

      test "part2" do
        assert part2(input("day_#{day}_example_1")) == 123
        assert part2(input("day_#{day}")) == 456
      end
    end
    """
  end
end
