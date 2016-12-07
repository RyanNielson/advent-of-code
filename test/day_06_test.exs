defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "parse" do
    assert Day06.parse(input_simple) == ["eedadn", "drvtee", "eandsr", "raavrd", "atevrs", "tsrnev", "sdttsa", "rasrtv", "nssdts", "ntnada", "svetve", "tesnvt", "vntsnd", "vrdear", "dvrsen", "enarar"]
  end

  test "run" do
    assert Day06.run(input_simple) == "easter"
    assert Day06.run(input) == "mlncjgdg"
  end

  defp input_simple do
    File.read!("test/input/day_06_simple.txt")
  end

  defp input do
    File.read!("test/input/day_06.txt")
  end
end
