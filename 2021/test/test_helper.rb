# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
# require "aoc/2021"

def input(file)
  file_path = File.expand_path("../input/#{file}", __FILE__)
  File.read(file_path).strip
end

require "minitest/autorun"
