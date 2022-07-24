# frozen_string_literal: true

module LeetCoder
  class Requests
    include LeetCoder::Queries

    def initialize
      @client = Client.new
    end

    def submission_detail(submission_id:)
      endpoint = "submissions/detail/#{submission_id}/"
      @client.call('get', endpoint)
    end

    def submissions(question_slug:)
      payload = { query: submissions_query(question_slug:) }
      @client.call('post', 'graphql', payload:)
    end

    def accepted_questions
      payload = { query: problemset_query, variables: { filters: { status: 'AC' } } }
      @client.call('post', 'graphql', payload:)
    end
  end
end
