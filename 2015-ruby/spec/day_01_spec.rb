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
end
