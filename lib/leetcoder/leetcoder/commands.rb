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
      Leetcoder::Download.call(options)
    end

    def define_commands(parser) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      parser.banner = 'Usage: leetcoder [commands]'
      parser.separator ''
      parser.separator '* indicates default value'
      parser.separator ''
      parser.separator 'commands:'

      parser.on(
        '-d',
        '--download [TYPE]',
        [DOWNLOAD_TYPE_ALL, DOWNLOAD_TYPE_ONE],
        'Specify number of accepted submission to download per problem (*one, all)'
      ) do |type|
        options[:download_type] = type || DOWNLOAD_TYPE_ONE
      end

      parser.on('-c', '--cookie', String, 'Input Leetcode Cookie') do
        store_cookie
        exit
      end

      parser.on('-f', '--folder FOLDER_PATH', String,
                'Specify download folder location (* <current_directory>/leetcode)') do |folder|
        options[:download_folder] = File.expand_path(folder)
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
  end
end
