# frozen_string_literal: true

module LeetCoder
  module Parser
    class Submissions < Base
      def list
        @list ||= @response.dig(:data, :submissionList, :submissions)
      end

      def accepted
        @accepted ||= list.select { |submission| submission[:statusDisplay] == 'Accepted' }
      end

      def urls
        @urls ||= accepted.map { |submission| submission[:url] }
      end
    end
  end
end
