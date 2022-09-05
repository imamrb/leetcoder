# frozen_string_literal: true

# Dir[File.join(__dir__, 'leetcoder', '**', '*.rb')].each { |file| require file }
require 'dotenv/load'
require 'base64'
require 'fileutils'
require 'nokogiri'
require 'yaml'
require 'pry'
require_relative 'leetcoder/version'
require_relative 'leetcoder/client'
require_relative 'leetcoder/collection'
require_relative 'leetcoder/object'
require_relative 'leetcoder/errors'
require_relative 'leetcoder/helpers/error_handler'
require_relative 'leetcoder/helpers/gql_queries'
require_relative 'leetcoder/helpers/logger'
require_relative 'leetcoder/helpers/utils'
require_relative 'leetcoder/objects/base_object'
require_relative 'leetcoder/objects/submission'
require_relative 'leetcoder/objects/question'
require_relative 'leetcoder/resources/base_resource'
require_relative 'leetcoder/resources/questions'
require_relative 'leetcoder/resources/submissions'
require_relative 'leetcoder/download_processor'
require_relative 'leetcoder/download'
require_relative 'leetcoder/commands'
require_relative 'leetcoder/cli'

module Leetcoder
  BASE_URL = 'https://leetcode.com'
  CONFIG_DIR = File.expand_path('~/.leetcoder')
  COOKIE_FILE = "#{CONFIG_DIR}/secret.txt".freeze
end
