# frozen_string_literal: true

require_relative 'lib/leetcoder/leetcoder/version'

Gem::Specification.new do |spec|
  spec.name = 'leetcoder'
  spec.version = Leetcoder::VERSION
  spec.authors = ['Imam Hossain']
  spec.email = ['imam.swe@gmail.com']

  spec.summary = 'A Ruby Leetcode Client to help you download and backup all your accepted leetcode submissions'
  spec.description = 'A Ruby Leetcode Client to download and backup your submissions with problem description'
  spec.homepage = 'https://www.github.com/imamrb/leetcoder'
  spec.license = 'MIT'
  spec.required_ruby_version = ">= #{File.read('.ruby-version')}"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'bin'
  spec.executables   = ['leetcoder']
  spec.require_paths = ['lib']

  # Dependency gems
  spec.add_dependency 'faraday', '~> 1.10'
  spec.add_dependency 'nokogiri', '~> 1.13'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
