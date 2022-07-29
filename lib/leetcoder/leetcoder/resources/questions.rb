# frozen_string_literal: true

module Leetcoder
  class QuestionsResource < BaseResource
    def list
      request = proc { gql_request(query: problemset_query, variables: { filters: {} }) }

      response = cache_response('questions_cache.yml', request, update: true)
      Collection.from_response(response.body, key: %i[data problemsetQuestionList questions])
    end

    def retrieve(title_slug)
      response = gql_request(query: question_data_query(title_slug:))

      Object.from_response(response.body, key: %i[data question])
    end

    def accepted_list
      @accepted_list ||= list.select { |question| question.status == 'ac' }
    end

    # private

    # def compact_list(input_list)
    #   input_list.map do |question|
    #     Object.new(
    #       question.to_h.slice(:titleSlug, :frontendQuestionId, :difficulty, :status).merge!(
    #         topicTags: question.topicTags.map(&:slug)
    #       )
    #     )
    #   end
    # end
  end
end
