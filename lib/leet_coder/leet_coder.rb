# frozen_string_literal: true

Dir[File.join(__dir__, 'leet_coder', '*.rb')].sort.each { |file| require file }

require 'dotenv/load'

require 'json'
require 'yaml'
require 'pry'
require 'faraday'
require 'faraday/net_http'
require 'awesome_print'
require 'fileutils'
require 'nokogiri'

module LeetCoder
  class Error < StandardError; end
  # Your code goes here...
end
