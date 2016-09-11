require 'open3'
require_relative 'parser'

module Pronto
  module Clippy
    class Wrapper
      def lint
        _, stderr, = Open3.capture3(*command)

        Parser.new(stderr).output
      end

      private

      def executable
        ENV['CARGO_PRONTO_PATH'] || 'cargo'
      end

      def command
        [executable, 'clippy', '--quiet', '--', '--error-format=json']
      end
    end
  end
end
