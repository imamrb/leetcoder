# frozen_string_literal: true

module Leetcoder
  class Collection
    attr_reader :data

    def self.from_response(response, key:, type: Object)
      response.dig(*key).map { |attrs| type.new(attrs) }
      # response.dig(*key[0...-1], 'total')
    end
  end
end
