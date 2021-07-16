require "day_04"

RSpec.describe Day04 do
  before(:each) do
    @day_04 = Day04.new
  end

  it "solves part 1" do
    expect(@day_04.part1("abcdef")).to eq(609043)
    expect(@day_04.part1("pqrstuv")).to eq(1048970)
    expect(@day_04.part1(input("day_04"))).to eq(254575)
  end

  it "solves part 2" do
    expect(@day_04.part2(input("day_04"))).to eq(1038736)
  end
end
