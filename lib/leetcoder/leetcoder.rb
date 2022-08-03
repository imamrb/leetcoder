# frozen_string_literal: true

Dir[File.join(__dir__, 'leetcoder', '**', '*.rb')].each { |file| require file }

require 'pry'
require 'yaml'
require 'dotenv/load'
require 'awesome_print'
require 'fileutils'
require 'nokogiri'

module Leetcoder
  class Error < StandardError; end

  BASE_URL = 'https://leetcode.com'

end
