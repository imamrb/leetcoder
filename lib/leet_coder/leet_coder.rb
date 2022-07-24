# frozen_string_literal: true

Dir[File.join(__dir__, 'leet_coder', '*.rb')].sort.each { |file| require file }

require 'dotenv/load'

module LeetCoder
  class Error < StandardError; end
  # Your code goes here...
end
