# frozen_string_literal: true

module Leetcoder
  module Helpers
    module ErrorHanlder
      # wrap code block with error_hanlder do; end to rescue errors
      def error_handler
        yield
      rescue OptionParser::InvalidArgument, OptionParser::InvalidOption => e
        puts "error: #{e}"
      rescue Errors::EmptyCommand
        puts 'No command supplied! Run `leetcoder --help` to see available commands.'
      rescue Errors::InvalidCommand
        puts 'Invalid Command!'
      rescue StandardError => e
        puts "error: #{e}"
        puts e.backtrace if ENV['TEST']
      ensure
        puts "\nRun `leetcoder --help` to see available commands."
      end
    end
  end
end
