require 'test_helper'

class Pronto::ClippyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Pronto::Clippy::VERSION
  end
end
