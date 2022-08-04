# frozen_string_literal: true

module Leetcoder
  class SubmissionsResource < BaseResource
    # returns a list of all the submissions for a problem
    def list
      response = gql_request(query: submissions_query(**args.slice(:title_slug)))

      Collection.from_response(response.body, key: %i[data submissionList submissions])
    end

    # returns a list of accepted submissions of the problem
    def accepted_list
      @accepted_list ||= list.select do |submission|
        submission.statusDisplay == 'Accepted'
      end
    end

    # returns a list of latest accepted submission from each language
    def uniq_accepted_list
      accepted_list
        .group_by(&:lang)
        .map { |x| x[1].first }
    end

    # returns the html object for a single submission
    def retrieve(url:)
      response = get_request(url)

      Object.from_html(response.body)
    end
  end
end
