# frozen_string_literal: true

require 'optparse'
require_relative 'helpers/error_hanlder'

module Leetcoder
  class Cli
    include Helpers::ErrorHanlder
    attr_reader :args, :commands

    def initialize(args)
      @args = args
      @commands = Commands.new
    end

    def self.start(args = ARGV.dup)
      new(args).start
    end

    def start
      error_handler do
        option_parser
      end
    end

    private

    def option_parser
      OptionParser.new do |parser|
        commands.define_commands(parser)
        parser.parse!(args)
        commands.run!
      end
    end
  end
end
