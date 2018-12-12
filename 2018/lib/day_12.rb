require 'set'

class Day12
  def part1(input)
    pots, rules = parse(input)

    20.times.reduce(pots) { |layout| new_pots(layout, rules)}.select{ |k, v| v == "#" }.keys.sum
  end

  def part2(input)
    pots, rules = parse(input)
    seen_values = Set.new
    first_stabilized = 0;

    50000000000.times do |i|
      pots = new_pots(pots, rules)

      pots_string = pots.values.map(&:to_s).join.gsub(/^\.+|\.+$/, "")

      first_stabilized = i

      break if seen_values.include?(pots_string)

      seen_values.add(pots_string)
    end

    offset = 50000000000 - first_stabilized - 1
    pots.select{ |k, v| v == "#" }.keys.sum{ |num| num + offset }
  end

  def new_pots(pots, rules)
    new_pots = {}

    keys =  pots.select{ |k, v| v == "#" }.keys.sort
    min, max = keys.minmax

    (min-5..max+5).to_a.each do |number|
        group = (number-2..number+2).to_a.map{ |num| pots[num] }.join
        new_pots[number] = rules[group]
    end

    new_pots
  end

  def parse(input)
    lines = input.split("\n")

    initial_state = lines[0].split.last.chars.each_with_index.reduce(Hash.new { |h, k| h[k] = "." }) do |pots, (pot, i)|
      pots[i] = pot
      pots
    end

    rules = lines[2..-1].reduce(Hash.new { |h, k| h[k] = "." }) do |patterns, rule|
      rule = rule.strip
      pattern, pot = rule.split(" => ")
      patterns[pattern] = pot
      patterns
    end

    [initial_state, rules]
  end
end
