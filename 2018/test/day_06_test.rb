require "test_helper"
require "day_06"

class Day04Test < Minitest::Test
  def setup
    @day_06 = Day06.new
  end

  def test_part_1
    assert_equal 17, @day_06.part1(sample_input_1)
    assert_equal 1876, @day_06.part1(sample_input_2) # Mine returns 1876
    assert_equal 4589, @day_06.part1(input("day_06.txt"))
  end

  def test_part_2
    assert_equal 16, @day_06.part2(sample_input_1, 32)
    assert_equal 40252, @day_06.part2(input("day_06.txt"), 10000)
  end

  def test_bounding_box
    assert_equal [1, 1, 8, 9], @day_06.bounding_box(sample_input_1_coords)
    assert_equal [0, 0, 100, 100], @day_06.bounding_box(sample_input_2_coords)
  end

  def test_manhattan_distance
    assert_equal 5, @day_06.manhattan_distance([1, 1], [1, 6])
    assert_equal 10, @day_06.manhattan_distance([3, 4], [8, 9])
  end

  def test_prep_input
    assert_equal sample_input_1_coords, @day_06.prep_input(sample_input_1)
    assert_equal sample_input_2_coords, @day_06.prep_input(sample_input_2)
  end

  def sample_input_1
    "1, 1
    1, 6
    8, 3
    3, 4
    5, 5
    8, 9"
  end

  def sample_input_2
    "0, 0
    0, 100
    1, 50
    80, 20
    80, 50
    80, 80
    100, 0
    100, 50
    100, 100"
  end

  def sample_input_1_coords
    [[1, 1], [1, 6], [8, 3], [3, 4], [5, 5], [8, 9]]
  end

  def sample_input_2_coords
    [[0, 0], [0, 100], [1, 50], [80, 20], [80, 50], [80, 80], [100, 0], [100, 50], [100, 100]]
  end
end
