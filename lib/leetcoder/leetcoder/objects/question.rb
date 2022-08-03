# frozen_string_literal: true

module Leetcoder
  class Question < BaseObject
    def save_to_file!
      File.write('README.md', question_data)
    end

    def question_data
      serialized_data.map { |key, value| block_format(key, value) }.join("<br> \n")
    end

    def serialized_data
      {
        title: object.title,
        url:,
        topic_tags:,
        difficulty: object.difficulty,
        content: object.content,
        stats:,
        likes: object.likes
      }
    end

    def url
      "#{Leetcoder::BASE_URL}/problems/#{object.titleSlug}"
    end

    def topic_tags
      object.topicTags.map { |tag| "##{tag[:slug]}" }.join(', ')
    end

    def stats
      JSON.parse(object.stats).slice(*%w[totalAccepted totalSubmission acRate]).map do |key, value|
        "#{key.upcase}: #{value}"
      end.join(', ')
    end

    private

    def block_format(key, value)
      return "\n<br>#{value}" if key == :content

      "<b> #{titelize(key)} :</b> #{value}"
    end

    def titelize(str)
      str.to_s.split('_').map(&:capitalize).join(' ')
    end
  end
end
