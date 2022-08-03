# frozen_string_literal: true

module Leetcoder
  module Utils
    LANGS_EXT = {
      bash: '.sh',
      c: '.c',
      cpp: '.cpp',
      csharp: '.cs',
      golang: '.go',
      java: '.java',
      javascript: '.js',
      kotlin: '.kt',
      mysql: '.sql',
      php: '.php',
      python: '.py',
      python3: '.py',
      ruby: '.rb',
      rust: '.rs',
      scala: '.scala',
      swift: '.swift'
    }.freeze

    def lang_to_ext(lang)
      LANGS_EXT[lang.to_sym]
    end
  end
end
