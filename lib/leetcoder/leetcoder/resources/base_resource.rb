# frozen_string_literal: true

module Leetcoder
  class BaseResource
    include Leetcoder::GqlQueries

    class Response < Object; end

    attr_reader :args

    def initialize(args = {})
      @client = Client.new
      @args = args
    end

    def cache_response(path, request, update: false)
      data = YAML.load_file(path) if File.exist? path
      return Response.new(body: data) unless update || data.nil?

      puts 'Caching Response..'

      request.call.tap do |response|
        File.write(path, response.body.to_yaml)
      end
    end

    def gql_request(query: {}, variables: {})
      payload = { query:, variables: }
      @client.call('post', 'graphql', payload:)
    end

    def get_request(endpoint, params: {})
      @client.call('get', endpoint, params:)
    end

    # def submission_detail(submission_id:)
    #   endpoint = "submissions/detail/#{submission_id}/"
    #   @client.call('get', endpoint)
    # end

    # def submissions(question_slug:)
    #   payload = { query: submissions_query(question_slug:) }
    #   @client.call('post', 'graphql', payload:)
    # end

    # def question_list
    #   payload = { query: problemset_query }
    #   @client.call('post', 'graphql', payload:)
    # end

    # def accepted_questions
    #   payload = { query: problemset_query, variables: { filters: { status: 'AC' } } }
    #   @client.call('post', 'graphql', payload:)
    # end
  end
end
