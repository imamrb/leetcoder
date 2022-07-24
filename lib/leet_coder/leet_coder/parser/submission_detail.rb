# frozen_string_literal: true

module LeetCoder
  module Parser
    class SubmissionDetail < Base
      def code
        code = html.search('script').text.scan(/(?<=submissionCode:).*'/).first.strip

        code.gsub!(/\\u(.{4})/) { |_match| [Regexp.last_match(1).to_i(16)].pack('U') }

        code.gsub!(/\A'|'\Z/, '')
      end

      def html
        @html ||= Nokogiri::HTML(@response)
      end
    end
  end
end
