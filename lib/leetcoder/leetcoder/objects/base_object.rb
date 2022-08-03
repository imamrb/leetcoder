# frozen_string_literal: true

module Leetcoder
  class BaseObject
    attr_reader :object, :args

    def initialize(object, **args)
      @object = object
      @args = args
    end
  end
end
