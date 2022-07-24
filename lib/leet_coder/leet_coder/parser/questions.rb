# frozen_string_literal: true

module LeetCoder
  module Parser
    class Questions < Base
      def list
        @list ||= @response.dig(:data, :problemsetQuestionList, :questions)
      end

      def compact_list
        @list.map do |q|
          q.slice(:titleSlug, :frontendQuestionId, :difficulty).merge!(
            topicTags: q[:topicTags].map { |tag| tag[:slug] }
          )
        end
      end
    end
  end
end
