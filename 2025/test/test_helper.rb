$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
# require "aoc2025"

def input(file)
  file_path = File.expand_path("../input/#{file}", __FILE__)
  File.read(file_path).strip
end

require "minitest/autorun"
