require "day_01"

RSpec.describe Day01 do
  before(:each) do
    @day_01 = Day01.new
  end

  it "solves part 1" do
    expect(@day_01.part1("(())")).to eq(0)
    expect(@day_01.part1("()()")).to eq(0)
    expect(@day_01.part1("(((")).to eq(3)
    expect(@day_01.part1("(()(()(")).to eq(3)
    expect(@day_01.part1("))(((((")).to eq(3)
    expect(@day_01.part1("())")).to eq(-1)
    expect(@day_01.part1("))(")).to eq(-1)
    expect(@day_01.part1(")))")).to eq(-3)
    expect(@day_01.part1(")())())")).to eq(-3)
    expect(@day_01.part1(input("day_01"))).to eq(74)
  end

  it "solves part 2" do
    expect(@day_01.part2(")")).to eq(1)
    expect(@day_01.part2("()())")).to eq(5)
    expect(@day_01.part2(input("day_01"))).to eq(1795)
  end


  # it "solves part 2" do
  #   expect(false).to eq(true)
  # end
end
  

# class Day01Test < Minitest::Test
#   def setup
#     @day_01 = Day01.new
#   end

#   def test_part1
#     assert_equal 3, @day_01.part1("+1, +1, +1")
#     assert_equal 0, @day_01.part1("+1, +1, -2")
#     assert_equal (-6), @day_01.part1("-1, -2, -3")
#     assert_equal 547, @day_01.part1(input("day_01.txt"))
#   end

#   def test_part2
#     assert_equal 0, @day_01.part2("+1, -1")
#     assert_equal 10, @day_01.part2("+3, +3, +4, -2, -4")
#     assert_equal 5, @day_01.part2("-6, +3, +8, +5, -6")
#     assert_equal 14, @day_01.part2("+7, +7, -2, -7, -4")
#     assert_equal 76414, @day_01.part2(input("day_01.txt"))
#   end
# end
