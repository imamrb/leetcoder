# frozen_string_literal: true

require 'faraday'
require 'faraday/net_http'
require 'faraday/retry'

module Leetcoder
  class Client
    class ApiError < StandardError; end
    class AuthenticationError < StandardError; end
    class InvalidCookie < StandardError; end

    def initialize(_args = {})
      @cookie = ENV.fetch('LEETCODE_COOKIE', nil) || read_cookie
    end

    # @params
    # request_type: [get, post, put, delete]
    # endpoint: part of the url after base url
    # payload: request body payload
    # params: filter params
    def call(request_type, endpoint, payload: {}, params: {})
      response = connection.public_send(request_type, endpoint) do |req|
        req.body = payload
        req.params = params
        req.headers['Cookie'] = cookie
        req.headers['Referer'] = BASE_URL
        req.headers['X-csrftoken'] = x_csrftoken
      end

      return response if valid_response?(response)

      client_error_handler(response)
    end

    def connection
      @connection ||= Faraday.new(url: Leetcoder::BASE_URL) do |f|
        f.request :json
        f.response :json, content_type: /\bjson$/, parser_options: { symbolize_names: true }
        f.request :multipart
        f.adapter :net_http
        f.request :retry, retry_options
      end
    end

    private

    attr_reader :cookie

    def retry_options
      {
        max: 2,
        interval: 2,
        interval_randomness: 0.5,
        backoff_factor: 2,
        methods: %i[get post put],
        exceptions: [Errno::ETIMEDOUT, Timeout::Error, Faraday::TimeoutError, Faraday::ClientError],
        retry_statuses: [500, 429]
      }.freeze
    end

    def valid_response?(response)
      return false unless (200...299).cover?(response.status)
      return true unless response.body.is_a? Hash

      response.body[:errors].nil? # additional check for graphql response
    end

    def read_cookie
      Base64.urlsafe_decode64(File.read(COOKIE_FILE))
    rescue StandardError
      raise AuthenticationError, 'Authentication Error! Please provide a valid leetcode cookie.'
    end

    # ?<= positive lookbehind ( precedded by )
    # ?= positivie lookahead ( followed by )
    # .*? non greedy match ( capture first matched group )
    def x_csrftoken
      cookie.match(/(?<=csrftoken=).*?(?=;)/)[0]
    rescue StandardError
      raise InvalidCookie, 'The cookie you entered is not valid. Please provide a valid leetcode cookie.'
    end

    def client_error_handler(response)
      case response.status
      when 200, 400
        raise ApiError, "status: #{response.status},\n" \
                        "code: GRAPHQL_ERROR, \nerrors: #{response.body[:errors]}"
      when 429
        raise ApiError, "status: #{response.status},\n" \
                        "code: RATE_LIMIT_EXCEEDED, \nerrors: [Please try again.]"
      when 404
        raise ApiError, "status: #{response.status},\n" \
                        "code: NOT_FOUND_ERROR,\n" \
                        "errors: [The resource you are looking for couldn't be found!]"
      else
        raise ApiError, "status: #{response.status},\n" \
                        "full_response: #{response.inspect.gsub(/"Cookie.*?",/, '<cookie>')}"
      end
    end
  end
end
