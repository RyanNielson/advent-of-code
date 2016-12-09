defmodule Day08Test do
  use ExUnit.Case
  doctest Day08

  test "run" do
    assert Day08.run(input_simple, 7, 3) == 6
    assert Day08.run(input, 50, 6) == 116
  end

  test "parse" do
    assert Day08.parse(input_simple) == input_simple_parsed
  end

  test "generate grid" do
    assert Day08.generate_screen(7, 3) == sample_screen
  end

  test "commands" do
    assert Day08.command(["rect", 3, 2], sample_screen) == sample_screen_rect
    assert Day08.command(["rotate", "column", 1, 1], sample_screen_rect) == rotated_column_sample_screen_rect
    assert Day08.command(["rotate", "row", 0, 4], rotated_column_sample_screen_rect) == rotated_row_sample_screen_rect
  end

  test "get column" do
    assert Day08.get_column(sample_screen, 0) == [".", ".", "."]
    assert Day08.get_column(sample_screen_rect, 1) == ["#", "#", "."]
  end

  test "get row" do
    assert Day08.get_row(sample_screen, 0) == [".", ".", ".", ".", ".", ".", "."]
    assert Day08.get_row(sample_screen_rect, 1) == ["#", "#", "#", ".", ".", ".", "."]
  end

  def rotate do
    assert Day08.rotate([".", "#", "."], 1) == [".", ".", "#"]
    assert Day08.rotate([".", "#", "."], 2) == ["#", ".", "."]
    assert Day08.rotate([".", "#", "."], 3) == [".", "#", "."]
  end

  defp input_simple do
    File.read!("test/input/day_08_simple.txt")
  end

  defp input do
    File.read!("test/input/day_08.txt")
  end

  defp input_simple_parsed do
    [
      ["rect", 3, 2],
      ["rotate", "column", 1, 1],
      ["rotate", "row", 0, 4],
      ["rotate", "column", 1, 1]
    ]
  end

  defp sample_screen do
    %{{0, 0} => ".", {0, 1} => ".", {0, 2} => ".",
      {1, 0} => ".", {1, 1} => ".", {1, 2} => ".",
      {2, 0} => ".", {2, 1} => ".", {2, 2} => ".",
      {3, 0} => ".", {3, 1} => ".", {3, 2} => ".",
      {4, 0} => ".", {4, 1} => ".", {4, 2} => ".",
      {5, 0} => ".", {5, 1} => ".", {5, 2} => ".",
      {6, 0} => ".", {6, 1} => ".", {6, 2} => "."}
  end

  defp sample_screen_rect do
    %{{0, 0} => "#", {0, 1} => "#", {0, 2} => ".",
      {1, 0} => "#", {1, 1} => "#", {1, 2} => ".",
      {2, 0} => "#", {2, 1} => "#", {2, 2} => ".",
      {3, 0} => ".", {3, 1} => ".", {3, 2} => ".",
      {4, 0} => ".", {4, 1} => ".", {4, 2} => ".",
      {5, 0} => ".", {5, 1} => ".", {5, 2} => ".",
      {6, 0} => ".", {6, 1} => ".", {6, 2} => "."}
  end

  defp rotated_column_sample_screen_rect do
    %{{0, 0} => "#", {0, 1} => "#", {0, 2} => ".",
      {1, 0} => ".", {1, 1} => "#", {1, 2} => "#",
      {2, 0} => "#", {2, 1} => "#", {2, 2} => ".",
      {3, 0} => ".", {3, 1} => ".", {3, 2} => ".",
      {4, 0} => ".", {4, 1} => ".", {4, 2} => ".",
      {5, 0} => ".", {5, 1} => ".", {5, 2} => ".",
      {6, 0} => ".", {6, 1} => ".", {6, 2} => "."}
  end

  defp rotated_row_sample_screen_rect do
    %{{0, 0} => ".", {0, 1} => "#", {0, 2} => ".",
      {1, 0} => ".", {1, 1} => "#", {1, 2} => "#",
      {2, 0} => ".", {2, 1} => "#", {2, 2} => ".",
      {3, 0} => ".", {3, 1} => ".", {3, 2} => ".",
      {4, 0} => "#", {4, 1} => ".", {4, 2} => ".",
      {5, 0} => ".", {5, 1} => ".", {5, 2} => ".",
      {6, 0} => "#", {6, 1} => ".", {6, 2} => "."}
  end
end
