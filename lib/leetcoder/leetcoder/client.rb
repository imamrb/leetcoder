# frozen_string_literal: true

module Leetcoder
  class Client
    class LeetcoderError < StandardError; end

    BASE_URL = 'https://leetcode.com'

    def initialize(_args = {})
      @client = Faraday.new(url: BASE_URL) do |f|
        f.request :json
        f.response :json, content_type: /\bjson$/, parser_options: { symbolize_names: true }
        f.request :multipart
        f.adapter :net_http
      end
      @cookie = ENV.fetch('LEETCODE_COOKIE')
    end

    def call(request_type, endpoint, payload: {}, params: {})
      response = @client.public_send(request_type, endpoint) do |req|
        req.body = payload
        req.params = params
        req.headers['Cookie'] = @cookie
        req.headers['Referer'] = BASE_URL
        req.headers['X-csrftoken'] = @cookie.match(/(?<=csrftoken=).*?(?=;)/)[0]
      end

      return response.body if valid_response?(response)

      error_handler(response)
    end

    private

    def valid_response?(response)
      (200...399).cover? response.status
    end

    def error_handler(response)
      raise LeetcoderError, "status_code : #{response.status}, " \
                            "response: #{response.inspect.gsub(/"Cookie.*?",/, '<cookie>')}"
    end
  end
end
