# frozen_string_literal: true

require 'leetcoder/leetcoder/helpers/utils'

module Leetcoder
  class Submission < BaseObject
    include Leetcoder::Helpers::Utils

    def save_to_file!
      File.write(file_name, code)
    end

    def code
      code = submission_data.scan(/(?<=submissionCode:).*'/).first.strip

      code.gsub!(/\\u(.{4})/) { |_match| [Regexp.last_match(1).to_i(16)].pack('U') }

      code.gsub!(/\A'|'\Z/, '')
    end

    def file_name
      name_prefix = "#{question_id}.solution#{serial}"
      # name_prefix += serial if serial
      "#{name_prefix}.#{lang_to_ext(lang)}"
    end

    private

    def serial
      return nil if args[:index].nil? || args[:index] < 2

      args[:index].to_s
    end

    def lang
      submission_data.scan(/(?<=getLangDisplay: ').*(?=')/).first.strip
    end

    def question_id
      submission_data.scan(/(?<=questionId: ').*(?=')/).first.strip
    end

    def submission_data
      object.search('script').text
    end
  end
end
