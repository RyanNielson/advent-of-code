require "test_helper"
require "day_01"

class Day01Test < Minitest::Test
  def test_that_it_has_a_version_number
    assert Day01.new.something == "banana"
  end

  def test_it_does_something_useful
    puts input("day_01.txt");

    assert false
  end
end
