class Day09
  def parse(input)
    /(\d+) players; last marble is worth (\d+) points/.match(input).captures.map(&:to_i)
  end

  # def part1(input)
  #   steps = related_steps(input)
  #   result = []

  #   while !steps.empty? do
  #     next_step = steps.keys.sort.find{ |letter| steps[letter].empty? }

  #     result << next_step
  #     steps.delete(next_step)
  #     steps.each { |key, dependencies| dependencies.delete(next_step) }
  #   end

  #   result.join
  # end

  # def part2(input, worker_count, step_duration)
  #   steps = related_steps(input)
  #   workers = Array.new(worker_count, [0, nil])
  #   done = []
  #   total_time = 0;

  #   0.step.each do |time|
  #     available_steps = steps.keys.sort.select{ |letter| steps[letter].empty? }
  #     available_workers = workers.each_with_index.select { |(t, letter), i| t <= 0 }

  #     available_steps.each_with_index do |step, i|
  #       worker = available_workers[i]

  #       unless worker.nil?
  #         workers[worker[1]] = [step_time(step, step_duration), step] unless worker.nil?
  #         steps.delete(step)
  #       end
  #     end

  #     workers = workers.map do |t, letter|
  #       t -= 1
  #       if t <= 0 && !letter.nil?
  #         done << letter
  #         steps.each { |key, dependencies| dependencies.delete(letter) }
  #         [0, nil]
  #       else
  #         [t, letter]
  #       end
  #     end

  #     total_time = time + 1
  #     busy_workers = workers.each_with_index.select { |(t, letter), i| t > 0 }
  #     break if steps.empty? && busy_workers.empty?
  #   end

  #   total_time
  # end


  # def related_steps(input)
  #   input.split("\n").map(&:strip).reduce(Hash.new { |h, k| h[k] = [] }) do |steps, line|
  #     a, b = /Step (.) must be finished before step (.) can begin./.match(line).captures

  #     steps[b] << a
  #     steps[a] = [] if steps[a].empty?
  #     steps
  #   end
  # end

  # def step_time(letter, step_duration)
  #   letter_value(letter) + step_duration
  # end

  # def letter_value(letter)
  #   letter.ord - "A".ord + 1
  # end
end
