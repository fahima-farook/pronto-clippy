require 'test_helper'

class Pronto::ClippyRunnerTest < Minitest::Test
  include TestRepo

  attr_accessor :patches

  def lint
    Pronto::ClippyRunner.new(patches)
  end

  def test_it_returns_empty_array_on_nil_patches
    self.patches = nil

    assert_empty lint.run
  end

  def test_it_returns_empty_array_on_empty_patches
    self.patches = nil

    assert_empty lint.run
  end

  def test_it_returns_messages_on_some_patches
    self.patches = repo.diff('master')

    assert_empty lint.run
  end
end
