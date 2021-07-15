require "day_03"

RSpec.describe Day03 do
  before(:each) do
    @day_03 = Day03.new
  end

  it "solves part 1" do
    expect(@day_03.part1(">")).to eq(2)
    expect(@day_03.part1("^>v<")).to eq(4)
    expect(@day_03.part1("^v^v^v^v^v")).to eq(2)
    expect(@day_03.part1(input("day_03"))).to eq(2081)
  end

  it "solves part 2" do
    expect(@day_03.part2("^v")).to eq(3)
    expect(@day_03.part2("^>v<")).to eq(3)
    expect(@day_03.part2("^v^v^v^v^v")).to eq(11)
    expect(@day_03.part2(input("day_03"))).to eq(2341)
  end
end
