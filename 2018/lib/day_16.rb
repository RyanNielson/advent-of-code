class Day16
  OPCODES = [
    :addr, :addi,
    :mulr, :muli,
    :banr, :bani,
    :borr, :bori,
    :setr, :seti,
    :gtir, :gtri, :gtrr,
    :eqir, :eqri, :eqrr
  ]

  def part1(input)
    groups = parse(input)

    valid_group_opcodes = groups.map do |(reg_before, instruction, reg_after)|
      (_, a, b, c) = instruction

      OPCODES.reduce([]) do |valid_opcodes, opcode|
        valid_opcodes << opcode if send(opcode, reg_before, a, b, c) == reg_after
        valid_opcodes
      end
    end

    valid_group_opcodes.map(&:count).select{ |count| count >= 3 }.count
  end

  def part2(input1, input2)
    groups = parse(input1)

    valid_group_opcodes = groups.reduce(Hash.new { |h, k| h[k] = [] }) do |nums, (reg_before, instruction, reg_after)|
      (num, a, b, c) = instruction

      nums[num] += OPCODES.reduce([]) do |valid_opcodes, opcode|
        valid_opcodes << opcode if send(opcode, reg_before, a, b, c) == reg_after
        valid_opcodes
      end

      nums
    end

    valid_unique_group_opcodes = valid_group_opcodes.reduce({}) do |memo, (key, value)|
      memo[key] = value.uniq
      memo
    end

    numbered_op_codes = Hash.new

    while !valid_unique_group_opcodes.empty?
      num, (opcode, ) = valid_unique_group_opcodes.find{ |k, v| v.count == 1 }
      numbered_op_codes[num] = opcode
      valid_unique_group_opcodes.delete(num)
      valid_unique_group_opcodes = valid_unique_group_opcodes.reduce({}) do |h, (k, v)|
        h[k] = v.reject { |op| op == opcode }
        h
      end
    end

    instructions = parse_instructions(input2)

    starting_reg = [0, 0, 0, 0]

    instructions.reduce([0, 0, 0, 0]) do |reg, instruction|
      (num, a, b, c) = instruction

      send(numbered_op_codes[num], reg, a, b, c)
    end.first
  end

  def addr(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] + reg[b]
    reg
  end

  def addi(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] + b
    reg
  end

  def mulr(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] * reg[b]
    reg
  end

  def muli(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] * b
    reg
  end

  def banr(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] & reg[b]
    reg
  end

  def bani(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] & b
    reg
  end

  def borr(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] | reg[b]
    reg
  end

  def bori(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] | b
    reg
  end

  def setr(reg, a, _, c)
    reg = reg.dup
    reg[c] = reg[a]
    reg
  end

  def seti(reg, a, _, c)
    reg = reg.dup
    reg[c] = a
    reg
  end

  def gtir(reg, a, b, c)
    reg = reg.dup
    reg[c] = a > reg[b] ? 1 : 0
    reg
  end

  def gtri(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] > b ? 1 : 0
    reg
  end

  def gtrr(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] > reg[b] ? 1 : 0
    reg
  end

  def eqir(reg, a, b, c)
    reg = reg.dup
    reg[c] = a == reg[b] ? 1 : 0
    reg
  end

  def eqri(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] == b ? 1 : 0
    reg
  end

  def eqrr(reg, a, b, c)
    reg = reg.dup
    reg[c] = reg[a] == reg[b] ? 1 : 0
    reg
  end

  def parse(input)
    parts = input.split("\n").map(&:strip)

    parts.each_slice(4).map do |chunk|
      before, instruction, after, _ = chunk

      [before.scan(/(\d+)/).flatten.map(&:to_i),
       instruction.scan(/(\d+)/).flatten.map(&:to_i),
       after.scan(/(\d+)/).flatten.map(&:to_i)]
    end
  end

  def parse_instructions(input)
    parts = input.split("\n").map(&:strip)

    parts.each.map do |instruction|
      instruction.scan(/(\d+)/).flatten.map(&:to_i)
    end
  end
end
