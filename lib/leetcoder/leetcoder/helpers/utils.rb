# frozen_string_literal: true

module Leetcoder
  module Helpers
    module Utils
      LANGS_EXT = {
        bash: 'sh',
        c: 'c',
        cpp: 'cpp',
        csharp: 'cs',
        golang: 'go',
        java: 'java',
        javascript: 'js',
        kotlin: 'kt',
        mysql: 'sql',
        php: 'php',
        python: 'py',
        python3: 'py',
        ruby: 'rb',
        rust: 'rs',
        scala: 'scala',
        swift: 'swift'
      }.freeze

      def lang_to_ext(lang)
        LANGS_EXT[lang.to_sym]
      end

      def create_directory(name)
        FileUtils.mkdir_p(name).first
      end

      # create an empty file and return the path
      # ex: create_file('~/leetcode/secret.txt')
      def create_file(file_path)
        FileUtils.mkdir_p(file_path.match(%r{.*(?=/)})[0]).then do
          FileUtils.touch(file_path).first
        end
      end

      def store_cookie
        puts 'Please paste your leetcode cookie below:'
        print ':>'
        cookie = $stdin.gets("\n").chomp

        File.write(create_file(COOKIE_FILE), Base64.urlsafe_encode64(cookie))

        puts "\nCookie is saved successfully! You can now access protected resources."
      end
    end
  end
end
