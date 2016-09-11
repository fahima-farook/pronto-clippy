require 'test_helper'

class Pronto::Clippy::ParserTest < Minitest::Test
  def data
    File.read('test/fixtures/output.json')
  end

  def subject
    Pronto::Clippy::Parser.new(data)
  end

  def test_it_has_2_entries
    refute_empty subject.output
  end

  def test_it_has_data_on_file
    assert_includes subject.output.keys, 'test/sample/src/lib.rs'
  end

  def test_one_error_is_about_unused_variable
    assert(subject.output['test/sample/src/lib.rs'].any? do |entry|
      entry['message'] =~ /unused variable/
    end)
  end
end
