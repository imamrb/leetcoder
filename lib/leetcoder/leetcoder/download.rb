# frozen_string_literal: true

module Leetcoder
  class Download
    include Helpers::Utils
    include Helpers::Logger

    def initialize(args)
      @args = args
      @question_resource = QuestionsResource.new
      @root_directory = create_directory(args[:download_folder] || 'leetcode')
    end

    def self.call(args = {})
      new(args).call
    end

    def call
      Dir.chdir(@root_directory) do
        download_accepted_submissions
      end
    end

    private

    attr_reader :args

    def download_accepted_submissions
      accepted_questions.each do |question|
        question_dir = "#{question.frontendQuestionId}.#{question.titleSlug}"
        next log_message(:skip, question_dir:) unless Dir.glob("#{question_dir}/*solution*").empty?

        log_message(:download, question_dir:)

        Dir.chdir(create_directory(question_dir)) do
          process_question(question)
          process_submissions(question)
        end
      end
    end

    def accepted_questions
      QuestionsResource.new.accepted_list.tap do |data|
        raise Errors::NoAcceptedQuestions if data.empty?
      end
    end

    def process_question(question)
      question_data = QuestionsResource.new.retrieve(question.titleSlug)
      Question.new(question_data).save_to_file!
    end

    def process_submissions(question)
      accepted_submissions(question).each_with_index do |sub, index|
        submission_data = SubmissionsResource.new.retrieve(url: sub.url)

        Submission.new(submission_data, index: index + 1).save_to_file!
      end
    end

    def accepted_submissions(question)
      resource = SubmissionsResource.new(title_slug: question.titleSlug)
      return resource.accepted_list if args[:download_type] == Commands::DOWNLOAD_TYPE_ALL

      resource.uniq_accepted_list # default list
    end
  end
end
