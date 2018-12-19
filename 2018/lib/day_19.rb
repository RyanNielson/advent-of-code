class Day19
  def part1(input)
    ip_index, instructions = parse(input)
    registers = [0, 0, 0, 0, 0, 0]

    while registers[ip_index] < instructions.length
      ip = registers[ip_index]
      instruction = instructions[ip]

      opcode, a, b, c = instruction

      registers = send(opcode, registers, a, b, c)

      registers[ip_index] += 1
    end

    registers[0]
  end

  # Brute forcing may not be viable, it's taking forever. This is not complete.
  # Instructions eventually start looping so maybe it can probably be optimized.
  # ["mulr", 4, 1, 3]
  # ["eqrr", 3, 5, 3]
  # ["addr", 3, 2, 2]
  # ["addi", 2, 1, 2]
  # ["addi", 1, 1, 1]
  # ["gtrr", 1, 5, 3]
  # ["addr", 2, 3, 2]
  # ["seti", 2, 5, 2]
  def part2(input)
    ip_index, instructions = parse(input)
    registers = [1, 0, 0, 0, 0, 0]
    i = 0
    while registers[ip_index] < instructions.length
      ip = registers[ip_index]
      instruction = instructions[ip]
      puts registers.inspect if i % 10000 == 0
      i += 1
      # puts instruction.inspect
      # puts ip.inspect
      # puts registers.inspect

      if ip == 3 #&& registers[3] != 0
        # puts "HERE"
        # registers[3] = registers[4] * registers[1]  # ["mulr", 4, 1, 3]
        # registers[3] = registers[3] == registers[5] ? 1 : 0     # ["eqrr", 3, 5, 3]

        if (registers[4] * registers[1] == registers[5]) || (registers[1] + 1 > registers[5])
          registers[3] = 1
        else
          registers[3] = 0
        end

        #registers[2] = reg[3] + reg[2]              # ["addr", 3, 2, 2]
        #registers[2] = reg[2] + 1                   # ["addi", 2, 1, 2]
        # registers[1] = reg[1] + 1                   # ["addi", 1, 1, 1]
        # registers[3] = registers[1] > registers[5] ? 1 : 0      # ["gtrr", 1, 5, 3]
        #registers[2] = reg[2] + reg[3]              # ["addr", 2, 3, 2]
        #registers[2] = 2                            # ["seti", 2, 5, 2]

        registers[1] = registers[1] + 1
        registers[2] = 12

        # registers[ip_index] = 11 # Might have to be 12 as well?
        next;
      end

      opcode, a, b, c = instruction
      registers = send(opcode, registers, a, b, c)
      registers[ip_index] += 1
    end

    registers[0]
  end

  def addr(reg, a, b, c)
    reg[c] = reg[a] + reg[b]
    reg
  end

  def addi(reg, a, b, c)
    reg[c] = reg[a] + b
    reg
  end

  def mulr(reg, a, b, c)
    reg[c] = reg[a] * reg[b]
    reg
  end

  def muli(reg, a, b, c)
    reg[c] = reg[a] * b
    reg
  end

  def setr(reg, a, _, c)
    reg[c] = reg[a]
    reg
  end

  def seti(reg, a, _, c)
    reg[c] = a
    reg
  end

  def gtrr(reg, a, b, c)
    reg[c] = reg[a] > reg[b] ? 1 : 0
    reg
  end

  def eqrr(reg, a, b, c)
    reg[c] = reg[a] == reg[b] ? 1 : 0
    reg
  end

  def parse(input)
    lines = input.split("\n").map(&:strip)

    ip = lines.first.match(/(\d)/).captures.first.to_i

    instructions = lines[1..-1].map do |line|
      instruction = line.scan(/(\w+) (\d+) (\d+) (\d+)/).flatten

      [instruction.first, instruction[1..-1].map(&:to_i)].flatten
    end

    [ip, instructions]
  end
end