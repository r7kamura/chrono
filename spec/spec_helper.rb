require "simplecov"
SimpleCov.start

if ENV["CI"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "chrono"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
