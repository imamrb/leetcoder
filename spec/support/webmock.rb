# frozen_string_literal: true

# spec/support/webmock.rb

# This line makes it so WebMock and RSpec know how to talk to each other.
require 'webmock/rspec'

# This line disables HTTP requests, with the exception of HTTP requests
# to localhost.
WebMock.disable_net_connect!(allow_localhost: true)
