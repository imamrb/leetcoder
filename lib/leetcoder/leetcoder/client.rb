# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'

module Leetcoder
  class Client
    class ApiError < StandardError; end

    def initialize(_args = {})
      @cookie = ENV.fetch('LEETCODE_COOKIE')
    end

    def call(request_type, endpoint, payload: {}, params: {})  # rubocop:disable Metrics/AbcSize
      response = connection.public_send(request_type, endpoint) do |req|
        req.body = payload
        req.params = params
        req.headers['Cookie'] = cookie
        req.headers['Referer'] = BASE_URL
        req.headers['X-csrftoken'] = cookie.match(/(?<=csrftoken=).*?(?=;)/)[0]
      end

      return response if valid_response?(response)

      error_handler(response)
    end

    def connection
      @connection ||= Faraday.new(url: Leetcoder::BASE_URL) do |f|
        f.request :json
        f.response :json, content_type: /\bjson$/, parser_options: { symbolize_names: true }
        f.request :multipart
        f.adapter :net_http
      end
    end

    private

    attr_reader :cookie

    def valid_response?(response)
      return false unless (200...399).cover?(response.status)
      return true unless response.body.is_a? Hash

      response.body[:errors].nil?
    end

    def error_handler(response)
      case response.status
      when 200, 400
        raise ApiError, "status: #{response.status},\n" \
                        "code: GRAPHQL_ERROR, \nerrors: #{response.body[:errors]}"
      when 404
        raise ApiError, "status: #{response.status},\n" \
                        "code: NOT_FOUND_ERROR,\n" \
                        "errors: [The resource you are looking for couldn't be found!]"
      else
        raise ApiError, "status: #{response.status},\n" \
                        "full_response: #{response.inspect.gsub(/"Cookie.*?",/, '<cookie>')}"
      end
    end

    def concat_gql_errors(errors)
      errors.map { |e| "#{e[:path].join(': ')}: #{e[:message]}" }.join('; ')
    end
  end
end
