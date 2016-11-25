require 'simplecov'

if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start do
  add_filter '/test/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'zero_formatter'

require "minitest/reporters"
if ENV["CIRCLE_TEST_REPORTS"]
  report_path = File.join(ENV["CIRCLE_TEST_REPORTS"], "test")
else
  report_path = "test/reports"
end
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new, Minitest::Reporters::JUnitReporter.new(report_path)]
require 'minitest/autorun'
require 'minitest/pride'

def fixture(path)
  File.read(File.expand_path("../fixture/#{path}", __FILE__))
end

def loaddump(type, value)
  klass = Class.new do
    include ZeroFormatter::ZeroFormattable

    field :value, type
  end

  obj = klass.new
  obj.value = value
  assert_equal(obj.value, value)
  assert_equal(obj.value, ZeroFormatter.load(klass, ZeroFormatter.dump(obj)).value)
end
