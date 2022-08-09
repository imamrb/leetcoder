# frozen_string_literal: true

module Leetcoder
  class QuestionsResource < BaseResource
    # returns the list of only accepted leetcode problems
    def accepted_list
      response = gql_request(query: problemset_query, variables: { filters: { status: 'AC' } })

      Collection.from_response(response.body, key: %i[data problemsetQuestionList questions])
    end

    # # returns the list of all leetcode problems, not usued
    def list
      request = proc { gql_request(query: problemset_query, variables: { filters: {} }) }

      response = cache_response('questions_cache.yml', request, update: false)
      Collection.from_response(response.body, key: %i[data problemsetQuestionList questions])
    end

    # returns a single problem data
    def retrieve(title_slug)
      response = gql_request(query: question_data_query(title_slug:))

      Object.from_response(response.body, key: %i[data question])
    end
  end
end
