require "fakeweb"
require "minitest/unit"
require "minitest/autorun"
require "mocha/setup"

require_relative "../lib/dalia_api_researcher"

class MiniTest::Unit::TestCase
  FIXTURES = File.expand_path("#{File.dirname(__FILE__)}/fixtures")
end

