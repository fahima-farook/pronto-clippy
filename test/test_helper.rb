$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pronto/clippy'

require 'minitest/autorun'
require 'minitest/pride'

module TestRepo
  def repo
    Pronto::Git::Repository.new('git')
  end

  def setup
    @old_dir = Dir.pwd
    Dir.chdir('test/fixtures/sample')
  end

  def teardown
    Dir.chdir(@old_dir)
  end
end
