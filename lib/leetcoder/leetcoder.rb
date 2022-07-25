# frozen_string_literal: true

Dir[File.join(__dir__, 'leetcoder', '*.rb')].each { |file| require file }

require 'dotenv/load'

require 'json'
require 'yaml'
require 'pry'
require 'faraday'
require 'faraday/net_http'
require 'awesome_print'
require 'fileutils'
require 'nokogiri'

module Leetcoder
  class Error < StandardError; end
  # Your code goes here...
end
