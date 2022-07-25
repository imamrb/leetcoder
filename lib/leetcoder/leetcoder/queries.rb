# frozen_string_literal: true

module Leetcoder
  module Queries
    def problemset_query(args = {})
      <<~GQL
        query problemsetQuestionList($filters: QuestionListFilterInput) {
          problemsetQuestionList: questionList(
            categorySlug: "#{args.fetch(:category_slug, 'algorithms')}",
            limit: #{args.fetch(:limit, -1)},
            skip: #{args.fetch(:skip, 0)},
            filters: $filters
          ) {
            total: totalNum
            questions: data {
              acRate
              difficulty
              freqBar
              frontendQuestionId: questionFrontendId
              isFavor
              paidOnly: isPaidOnly
              status
              title
              titleSlug
              topicTags {
                name
                id
                slug
              }
              hasSolution
              hasVideoSolution
            }
          }
        }
      GQL
    end

    def submissions_query(args = {})
      <<~GQL
        query Submissions {
          submissionList(
            questionSlug: "#{args[:question_slug]}",
            limit: #{args.fetch(:limit, 1000)},
            offset: #{args.fetch(:skip, 0)}
          ) {
            lastKey
            hasNext
            submissions {
              id
              statusDisplay
              lang
              runtime
              timestamp
              url
              isPending
              memory
            }
          }
        }
      GQL
    end
  end
end
