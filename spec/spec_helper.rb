require 'rspec'
require 'finfast'

DECIMAL_TOLERANCE = 1e-10

def near_zero(value)
  value.abs < DECIMAL_TOLERANCE
end

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

RSpec::Matchers.define :be_near do |expected|
  match do |actual|
    near_zero(actual - expected)
  end
end
