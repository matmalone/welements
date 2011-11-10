# begin
#   require 'context'
#   require 'matchy'
# rescue LoadError => e
#   if require 'rubygems' then retry
#   else raise(e)
#   end
# end

require 'test/unit'

require File.join(File.dirname(__FILE__), '..', 'lib', 'noaa')

module NOAA
  class TestCase < ::Test::Unit::TestCase
    def test_blank
      assert true
    end
  end
end
