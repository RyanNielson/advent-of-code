$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "minitest/autorun"
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

def input(file)
  file_path = File.expand_path("../input/#{file}", __FILE__)
  File.read(file_path).strip
end

def input_no_strip(file)
  file_path = File.expand_path("../input/#{file}", __FILE__)
  File.read(file_path)
end
