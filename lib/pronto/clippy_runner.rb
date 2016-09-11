require 'pronto'
require_relative 'clippy/wrapper'

module Pronto
  class ClippyRunner < Runner
    def run
      return [] unless @patches

      @offences = Clippy::Wrapper.new.lint

      @patches
        .reject { |patch| patch.additions.zero? }
        .select { |patch| rust_file?(patch.new_file_full_path.to_s) }
        .map { |patch| inspect(patch) }
    end

    private

    def inspect(patch)
      @offences
        .fetch(patch.new_file_full_path.to_s, [])
        .inject([]) do |arr, offence|
        span = offence['spans']
        line_start = span['line_start'].to_i
        line_end = span['line_end'].to_i

        line = patch.added_lines.find do |nr|
          (line_start..line_end).cover?(nr)
        end

        arr << new_message(offence, line) if line
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      Message.new(path,
                  line,
                  offence['level'],
                  offence['message'],
                  nil,
                  self.class)
    end

    def rust_file?(path)
      %w(.rs).include?(File.extname(path))
    end
  end
end
