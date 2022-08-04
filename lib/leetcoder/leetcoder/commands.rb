# frozen_string_literal: true

require 'optparse'

module Leetcoder
  class Commands
    DOWNLOAD_TYPE_ONE = :one
    DOWNLOAD_TYPE_ALL = :all

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def run!
      validate!
      Leetcoder::Download.call(options)
    end

    def define_commands(parser)
      parser.banner = 'Usage: leetcoder [commands]'
      parser.separator ''
      parser.separator 'commands:'

      parser.on('-d', '--download [DOWNLOAD_TYPE]', download_types, 'Download types') do |type|
        options[:download_type] = type || DOWNLOAD_TYPE_ONE
      end

      parser.on_tail('-v', '--version', 'Show version') do
        puts Leetcoder::VERSION
        exit
      end

      parser.on_tail('-h', '--help', 'Show available commands') do
        puts parser
        exit
      end
    end

    private

    def validate!
      raise Errors::EmptyCommand if options.empty?
    end

    def download_types
      [DOWNLOAD_TYPE_ALL, DOWNLOAD_TYPE_ONE]
    end
  end
end
