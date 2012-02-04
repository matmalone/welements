require 'test/unit'

require File.join(File.dirname(__FILE__), '..', 'lib', 'welements')

module Welements
  class TestCase < ::Test::Unit::TestCase
    def test_blank
      assert true
    end
  end
end
