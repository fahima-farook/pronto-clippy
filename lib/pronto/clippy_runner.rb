require 'pronto'
require 'pry'
require_relative 'clippy/wrapper'

module Pronto
  class ClippyRunner < Runner
    attr_reader :patches

    def run
      binding.pry
      return [] unless @patches


      patches
        .reject { |patch| patch.additions.zero? }
        .select { |patch| rust_file?(patch.new_file_full_path.to_s) }
        .map { |patch| inspect(patch) }
    end

    def offences
      binding.pry
      @offences ||= Clippy::Wrapper.new.lint
    end

    private

    def inspect(patch)
      binding.pry
      offences
        .fetch(patch.new_file_full_path.to_s, [])
        .inject([]) do |arr, offence|
        line = contains?(patch, offence['spans'].first)
          binding.pry
        arr << new_message(offence, line) if line
        arr
      end
    end

    def contains?(patch, span)
      line_start = span['line_start'].to_i
      line_end = span['line_end'].to_i

      patch.added_lines.find do |entry|
        (line_start..line_end).cover?(entry.new_lineno)
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      Message.new(path,
                  line,
                  offence['level'].to_sym,
                  offence['message'],
                  nil,
                  self.class)
    end

    def rust_file?(path)
      %w(.rs).include?(File.extname(path))
    end
  end
end
