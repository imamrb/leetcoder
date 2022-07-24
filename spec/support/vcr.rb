# frozen_string_literal: true

# spec/support/vcr.rb

require 'vcr'

VCR.configure do |c|
  # This is the directory where VCR will store its "cassettes", i.e. its
  # recorded HTTP interactions.
  c.cassette_library_dir = 'spec/cassettes'

  # This line makes it so VCR and WebMock know how to talk to each other.
  c.hook_into :webmock

  # This line makes VCR ignore requests to localhost. This is necessary
  # even if WebMock's allow_localhost is set to true.
  c.ignore_localhost = true

  # ChromeDriver will make requests to chromedriver.storage.googleapis.com
  # to (I believe) check for updates. These requests will just show up as
  # noise in our cassettes unless we tell VCR to ignore these requests.
  c.ignore_hosts 'chromedriver.storage.googleapis.com'

  %w[Cookie X-Csrftoken].each do |key|
    c.filter_sensitive_data("<#{key}>") do |interaction|
      interaction.request.headers[key].first
    end
  end

  c.configure_rspec_metadata!

  vcr_mode = ENV['VCR_MODE']&.match?(/all/i) ? :all : :once

  c.default_cassette_options = {
    record: vcr_mode,
    match_requests_on: %i[method uri]
  }
end

def vcr(casette, &)
  VCR.use_cassette(casette, &)
end
