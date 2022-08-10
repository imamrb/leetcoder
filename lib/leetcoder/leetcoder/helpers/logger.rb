# frozen_string_literal: true

module Leetcoder
  module Helpers
    module Logger
      def log_message(key, **args)
        puts message(key, args)
      end

      private

      def message(key, args)
        case key
        when :skip_submission
          "Skipping Download for #{args[:question_dir]}. Already Exist."
        when :submission_download
          "Downloading sumbimissions for #{args[:question_dir]}"
        when :initiate_download
          "Starting download in location: #{File.expand_path args[:dir]}\n"
        when :completed_download
          "\nDownload completed!"
        end
      end
    end
  end
end
