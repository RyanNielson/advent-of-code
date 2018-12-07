class Day07
  # def part1(input)
  #   steps = related_steps(input)
  #   result = []
  #   while !steps.empty? do

  #     next_step = steps.keys.sort.find{ |letter| steps[letter].empty? }

  #     result << next_step
  #     steps.delete(next_step)

  #     steps.each do |key, dependencies|
  #       steps[key] = dependencies.delete_if { |dep| result.include?(dep) }
  #     end
  #   end

  #   result.join
  # end

  def part1(input)
    steps = related_steps(input)
    result = []

    while !steps.empty? do
      next_step = steps.keys.sort.find{ |letter| steps[letter].empty? }

      result << next_step
      steps.delete(next_step)
      steps.each { |key, dependencies| dependencies.delete(next_step) }
    end

    result.join
  end


  def related_steps(input)
    input.split("\n").map(&:strip).reduce(Hash.new { |h, k| h[k] = [] }) do |steps, line|
      a, b = /Step (.) must be finished before step (.) can begin./.match(line).captures

      steps[b] << a
      steps[a] = [] if steps[a].empty?
      steps
    end
  end

  def determine_starting_steps(steps)
    (steps.values.flatten - steps.keys).uniq
  end

  def letter_value(letter)
    letter.ord - "A".ord + 1
  end
end
