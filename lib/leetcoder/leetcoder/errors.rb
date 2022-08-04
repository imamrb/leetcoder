# frozen_string_literal: true

module Leetcoder
  class Error < StandardError; end

  module Errors
    class EmptyCommand < Leetcoder::Error; end
    class InvalidCommand < Leetcoder::Error; end
  end
end
