$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "advent_of_code_2018"

require "minitest/autorun"
require 'minitest/reporters'
reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]
