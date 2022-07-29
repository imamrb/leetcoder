# frozen_string_literal: true

module Leetcoder
  class SubmissionsResource < BaseResource
    def list
      response = gql_request(query: submissions_query(**args.slice(:title_slug)))

      Collection.from_response(response.body, key: %i[data submissionList submissions])
    end

    def accepted_list
      @accepted_list ||= list.select do |submission|
        submission.statusDisplay == 'Accepted'
      end
    end

    def uniq_accepted_list
      accepted_list
        .group_by(&:lang)
        .map { |x| x[1].first }
    end

    def retrieve(url:)
      response = get_request(url)

      Object.from_html(response.body)
    end
  end
end
