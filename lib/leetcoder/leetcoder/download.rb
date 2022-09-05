# frozen_string_literal: true

module Leetcoder
  class Download
    include Helpers::Utils
    include Helpers::Logger

    def initialize(args)
      @args = args
      @root_directory = create_root_directory
    end

    def self.call(**args)
      new(args).call
    end

    def call
      Dir.chdir(@root_directory) do
        log_message(:initiate_download, dir: @root_directory)

        DownloadProcessor.call(**args).tap { log_message(:completed_download) }
      end
    end

    private

    attr_reader :args

    def create_root_directory
      create_directory(args[:download_folder] || ENV.fetch('DEFAULT_DIR', './'))
    end
  end
end
