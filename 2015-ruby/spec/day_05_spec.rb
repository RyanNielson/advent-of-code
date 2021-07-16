require "day_05"

RSpec.describe Day05 do
  before(:each) do
    @day_05 = Day05.new
  end

  it "solves part 1" do
    expect(@day_05.part1("ugknbfddgicrmopn")).to eq(1)
    expect(@day_05.part1("aaa")).to eq(1)
    expect(@day_05.part1("jchzalrnumimnmhp")).to eq(0)
    expect(@day_05.part1("haegwjzuvuyypxyu")).to eq(0)
    expect(@day_05.part1("dvszwmarrgswjxmb")).to eq(0)
    expect(@day_05.part1(input("day_05"))).to eq(255)
  end

  # it "solves part 2" do
  #   expect(@day_04.part2(input("day_04"))).to eq(1038736)
  # end
end
