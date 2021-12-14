class Day14
  def part1(input)
    steps(input, 10)
  end

  def part2(input)
    steps(input, 40)
  end

  def steps(input, amount)
    pairs, elements, rules = parse_input(input)

    amount.times do
      pairs.clone.each do |pair, val|
        elements[rules[pair]] += val
        pairs["#{pair[0]}#{rules[pair]}"] += val
        pairs["#{rules[pair]}#{pair[1]}"] += val
        pairs[pair] -= val
      end
    end

    elements.values.max - elements.values.min
  end

  def parse_input(input)
    template, _, *rule_inputs = input.split("\n")

    pairs = template.chars.each_cons(2).map(&:join).tally
    pairs.default = 0
    elements = template.chars.tally
    elements.default = 0

    parsed_rules = rule_inputs.each_with_object({}) do |rule, rules|
      rules.store(*rule.split(" -> "))
    end

    [pairs, elements, parsed_rules]
  end
end
