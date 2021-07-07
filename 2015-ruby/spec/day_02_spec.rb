require "day_02"

RSpec.describe Day02 do
  before(:each) do
    @day_02 = Day02.new
  end

  it "solves part 1" do
    expect(@day_02.part1("2x3x4")).to eq(58)
    expect(@day_02.part1("1x1x10")).to eq(43)
    expect(@day_02.part1(input("day_02"))).to eq(1588178)
  end

  it "solves part 2" do
    expect(@day_02.part2("2x3x4")).to eq(34)
    expect(@day_02.part2("1x1x10")).to eq(14)
    expect(@day_02.part2(input("day_02"))).to eq(3783758)
  end
end
