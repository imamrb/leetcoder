# frozen_string_literal: true

require 'leetcoder/leetcoder'

Dir[File.join(__dir__, 'support', '**', '*.rb')].each { |f| require f }
ENV['TEST'] = 'true'
ENV['DEFAULT_DIR'] = 'tmp/test'
# NOTE: Requires the actual cookie VCR_MODE=all is set
ENV['LEETCODE_COOKIE'] = if ENV['VCR_MODE'].eql?('all')
                           ENV.fetch('LEETCODE_COOKIE')
                         else
                           'csrftoken=4aB9fJwE3hxkolwtcZo; LEETCODE_SESSION=dskjflskjfk'
                         end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
