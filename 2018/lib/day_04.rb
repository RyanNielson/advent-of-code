class Day04
  def part1(input)
    events = split_input(input)
    sleep_log = build_sleep_log(events)

    sleepiest_guard_id = sleepiest_guard_id(sleep_log)
    sleepiest_guard_id * sleepiest_minute(sleep_log[sleepiest_guard_id])
  end

  def part2(input)
    events = split_input(input)
    sleep_log = build_sleep_log(events)

    guard_id, mins = sleep_log.max_by do |id, minutes|
      minutes.max_by { |minute, count| count }[1]
    end

    guard_id * sleepiest_minute(mins)
  end

  def build_sleep_log(events)
    sleep_log = Hash.new { |h, k| h[k] = Hash.new(0) }
    current_guard = nil
    sleep_start = 0

    events.each do |event|
      if (match = guard_begins_shift(event))
        current_guard = match.captures.first.to_i
      elsif (match = guard_falls_asleep(event))
        sleep_start = match.captures.first.to_i
      elsif (match = guard_wakes_up(event))
        sleep_end = match.captures.first.to_i
        sleep_range = sleep_start...sleep_end

        sleep_range.each { |minute| sleep_log[current_guard][minute] += 1 }
      end
    end

    sleep_log
  end

  def sleepiest_guard_id(sleep_log)
    sleep_log.max_by { |id, minutes| minutes_asleep(minutes) }[0]
  end

  def minutes_asleep(minutes_count)
    minutes_count.sum { |minute, count| count }
  end

  def sleepiest_minute(minutes_count)
    minutes_count.max_by { |minute, count| count }[0]
  end

  def guard_begins_shift(event)
    /\[\d+-\d+-\d+ \d+:\d+\] Guard #(\d+) begins shift/.match(event)
  end

  def guard_falls_asleep(event)
    /\[\d+-\d+-\d+ \d+:(\d+)\] falls asleep/.match(event)
  end

  def guard_wakes_up(event)
    /\[\d+-\d+-\d+ \d+:(\d+)\] wakes up/.match(event)
  end

  def split_input(input)
    input.split("\n").map(&:strip).sort
  end
end
