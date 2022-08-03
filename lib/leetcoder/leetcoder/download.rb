# frozen_string_literal: true

module Leetcoder
  class Download
    def initialize
      @q_resource = QuestionsResource.new
      @root_directory = create_directory('leetcoder')
    end

    def self.download_ac_submissions
      new.download_ac_submissions
    end

    def download_ac_submissions
      Dir.chdir(@root_directory) do
        download_submissions
      end
    end

    private

    def download_submissions
      accepted_qlist.each do |question|
        question_dir = "#{question.frontendQuestionId}.#{question.titleSlug}"

        Dir.chdir(create_directory(question_dir)) do
          next if File.exist?('README.md')

          process_question(question)
          process_submissions(question)
        end
      end
    end

    def accepted_qlist
      @q_resource.accepted_list
    end

    def process_question(question)
      response = @q_resource.retrieve(question.titleSlug)
      Question.new(response).save_to_file!
    end

    def process_submissions(question)
      q_submissions(question).each do |sub|
        response = SubmissionsResource.new.retrieve(url: sub.url)

        Submission.new(response, data: sub).save_to_file!
      end
    end

    def q_submissions(question)
      SubmissionsResource.new(title_slug: question.titleSlug).uniq_accepted_list
    end

    def create_directory(name)
      FileUtils.mkdir_p(name).first
    end
  end
end
