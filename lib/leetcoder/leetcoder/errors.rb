# frozen_string_literal: true

module Leetcoder
  class Error < StandardError; end

  module Errors
    class EmptyCommand < Leetcoder::Error; end
    class InvalidCommand < Leetcoder::Error; end

    class NoAcceptedQuestions < Leetcoder::Error
      def to_s
        'No accepted problems found on your account.' \
          'Please update LEETCODE COOKIE and try again if you think this is an error.'
      end
    end
  end
end
