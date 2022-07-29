# frozen_string_literal: true

module Leetcoder
  module GqlQueries
    def problemset_query(args = {})
      <<~GQL
        query problemsetQuestionList($filters: QuestionListFilterInput) {
          problemsetQuestionList: questionList(
            categorySlug: "#{args.fetch(:categorySlug, 'algorithms')}",
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

    def question_data_query(args = {})
      <<~GQL
        query questionData {
          question(titleSlug: "#{args[:title_slug]}") {
            questionId
            title
            titleSlug
            content
            difficulty
            categoryTitle
            stats
            topicTags {
              name
              slug
              translatedName
            }
            likes dislikes isLiked similarQuestions exampleTestcases
          }
        }
      GQL
    end

    def submissions_query(args = {})
      <<~GQL
        query Submissions {
          submissionList(
            questionSlug: "#{args[:title_slug]}",
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
