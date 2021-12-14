class Day12
  def part1(input)
    traverse(parse(input), method(:part_1_rules)).count
  end

  def part2(input)
    traverse(parse(input), method(:part_2_rules)).count
  end

  def traverse(connections, rules)
    final_paths = []
    paths = [["start"]]

    until paths.empty?
      current_path = paths.pop
      current_cave = current_path.last

      final_paths << current_path if current_cave == "end"

      connections[current_cave].each do |cave|
        paths << [*current_path, cave] if rules.call(cave, current_path)
      end
    end

    final_paths
  end

  def part_1_rules(cave, current_path)
    cave.upcase == cave || !current_path.include?(cave)
  end

  def part_2_rules(cave, current_path)
    visited_lower_twice = current_path
                          .filter { _1.downcase == _1 }
                          .tally
                          .values
                          .any? { _1 > 1 }

    cave.upcase == cave || !current_path.include?(cave) || !visited_lower_twice
  end

  def parse(input)
    input
      .split("\n")
      .map { _1.split("-") }
      .each_with_object(Hash.new { |h, k| h[k] = [] }) do |(a, b), connections|
        connections[a] << b if b != "start" && a != "end"
        connections[b] << a if a != "start" && b != "end"
      end
  end
end
