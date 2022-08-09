# frozen_string_literal: true

module Leetcoder
  module Helpers
    module ErrorHandler
      # wrap code block with error_hanlder do; end to rescue errors
      def error_handler
        yield
      rescue OptionParser::InvalidArgument, OptionParser::InvalidOption => e
        puts "error: #{e}"
        puts help_toast
      rescue Errors::EmptyCommand
        puts "Hi there! Please provide a valid command! #{help_toast} "
      rescue Errors::InvalidCommand
        puts "Invalid Command! #{help_toast}"
      rescue StandardError => e
        puts "error: #{e}"
        puts e.backtrace if ENV['TEST']
      end

      def help_toast
        "\nRun `leetcoder --help` to see available commands."
      end
    end
  end
end
