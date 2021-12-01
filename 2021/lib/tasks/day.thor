require "net/http"

class Day < Thor
  include Thor::Actions

  argument :number

  def self.source_root
    File.dirname(__FILE__)
  end

  desc "setup", "creates all the files for a new day"
  def setup
    parsed_number = number
    parsed_number = parsed_number[1..] if parsed_number.start_with?("0")

    uri = URI("https://adventofcode.com/2021/day/#{parsed_number}/input")
    example_input = Net::HTTP.get(uri, { "Cookie" => "session=#{File.read(".aoc-session").strip}" })

    template "templates/new_day.rb.tt", "lib/day_#{number}.rb"
    template "templates/new_day_test.rb.tt", "test/day_#{number}_test.rb"
    create_file "test/input/day_#{number}", example_input
  end
end
