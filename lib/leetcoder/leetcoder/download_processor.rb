# frozen_string_literal: true

module Leetcoder
  class DownloadProcessor
    include Helpers::Utils
    include Helpers::Logger

    def initialize(args)
      @args = args
    end

    def self.call(**args)
      new(args).call
    end

    def call
      download_accepted_submissions
    end

    private

    attr_reader :args

    def download_accepted_submissions
      accepted_questions.each do |question|
        @question = question
        next log_message(:skip_submission, question_dir:) if solutions_exist?

        log_message(:submission_download, question_dir:)

        Dir.chdir(create_directory(question_dir)) do
          process_question
          process_submissions
        end
      end
    end

    def accepted_questions
      QuestionsResource.new.accepted_list.tap do |data|
        raise Errors::NoAcceptedQuestions if data.empty?
      end
    end

    def question_dir
      "#{@question.frontendQuestionId}.#{@question.titleSlug}"
    end

    def solutions_exist?
      !Dir.glob("#{question_dir}/*solution*").empty?
    end

    def process_question
      question_data = QuestionsResource.new.retrieve(@question.titleSlug)
      Question.new(question_data).save_to_file!
    end

    def process_submissions
      accepted_submissions.each_with_index do |sub, index|
        submission_data = SubmissionsResource.new.retrieve(url: sub.url)

        Submission.new(submission_data, index: index + 1).save_to_file!
      end
    end

    def accepted_submissions
      resource = SubmissionsResource.new(title_slug: @question.titleSlug)
      return resource.accepted_list if args[:download_type] == Commands::DOWNLOAD_TYPE_ALL

      resource.uniq_accepted_list # default list
    end
  end
end
