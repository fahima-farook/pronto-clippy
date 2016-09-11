require 'json'

module Pronto
  module Clippy
    class Parser
      include Enumerable

      attr_reader :output

      def initialize(output)
        @output = output
                 .each_line
                 .map { |json| JSON.parse(json) }
                 .group_by do |entry|
          File.expand_path(entry['spans'].first['file_name'])
        end
      end

      def each
        output.each
      end
    end
  end
end
