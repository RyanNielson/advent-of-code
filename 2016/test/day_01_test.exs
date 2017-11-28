defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "run" do
    assert Day01.run(input_sample_1) == 5
    assert Day01.run(input_sample_2) == 2
    assert Day01.run(input_sample_3) == 12
    assert Day01.run(input) == 301
  end

  test "parse input into list" do
    assert Day01.parse(input_sample_1) == [{:R, 2}, {:L, 3}]
    assert Day01.parse(input_sample_2) == [{:R, 2}, {:R, 2}, {:R, 2}]
    assert Day01.parse(input_sample_3) == [{:R, 5}, {:L, 5}, {:R, 5}, {:R, 3}]
  end

  test "distance travelled" do
    assert Day01.distance({2, 3}) == 5
    assert Day01.distance({0, 2}) == 2
    assert Day01.distance({10, 2}) == 12
    assert Day01.distance({-5, 3}) == 8
    assert Day01.distance({-2, -4}) == 6
  end

  defp input_sample_1 do
    "R2, L3"
  end

  defp input_sample_2 do
    "R2, R2, R2"
  end

  defp input_sample_3 do
    "R5, L5, R5, R3"
  end

  defp input do
    File.read!("test/input/day_01.txt")
  end
end
