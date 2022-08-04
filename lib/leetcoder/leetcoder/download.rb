# frozen_string_literal: true

module Leetcoder
  class Download
    def initialize
      @question_resource = QuestionsResource.new
      @root_directory = create_directory('leetcoder')
    end

    def self.call
      new.call
    end

    def call
      Dir.chdir(@root_directory) do
        download_accepted_submissions
      end
    end

    private

    def download_accepted_submissions
      accepted_questions.each do |question|
        question_dir = "#{question.frontendQuestionId}.#{question.titleSlug}"
        next if Dir.exit? question_dir

        Dir.chdir(create_directory(question_dir)) do
          process_question(question)
          process_submissions(question)
        end
      end
    end

    def accepted_questions
      @question_resource.accepted_list
    end

    def process_question(question)
      question_data = @question_resource.retrieve(question.titleSlug)
      Question.new(question_data).save_to_file!
    end

    def process_submissions(question)
      accepted_submissions(question).each do |sub|
        submission_data = SubmissionsResource.new.retrieve(url: sub.url)

        Submission.new(submission_data).save_to_file!
      end
    end

    def accepted_submissions(question)
      SubmissionsResource.new(title_slug: question.titleSlug).uniq_accepted_list
    end

    # find or create directory and returns the name
    def create_directory(name)
      FileUtils.mkdir_p(name).first
    end
  end
end
