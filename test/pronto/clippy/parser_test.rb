require 'test_helper'

class Pronto::Clippy::ParserTest < Minitest::Test
  def data
    File.read('test/fixtures/output.json')
  end

  def path
    File.expand_path('test/sample/src/lib.rs')
  end

  def subject
    Pronto::Clippy::Parser.new(data)
  end

  def test_it_has_2_entries
    refute_empty subject.output
  end

  def test_it_has_data_on_file
    assert_includes subject.output.keys, path
  end

  def test_one_error_is_about_unused_variable
    assert(subject.output[path].any? do |entry|
      entry['message'] =~ /unused variable/
    end)
  end
end
