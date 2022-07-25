# frozen_string_literal: true

RSpec.describe Leetcode::Requests do
  let!(:instance) { described_class.new }

  describe '.submission_detail' do
    let!(:response) do
      vcr 'submssion_detail' do
        instance.submission_detail(submission_id: '641132932')
      end
    end

    it 'returns a valid response' do
      expect(response).to include('submissionCode')
    end
  end

  describe '.submissions' do
    let!(:response) do
      vcr 'submissions' do
        instance.submissions(question_slug: 'longest-substring-without-repeating-characters')
      end
    end

    it 'includes submissionList' do
      expect(response[:data]).to include(:submissionList)
      expect(response.dig(:data, :submissionList)).to include(:submissions)
    end
  end

  describe '.accepted_questions' do
    let!(:response) do
      vcr 'accepted_questions' do
        instance.accepted_questions
      end
    end

    it 'includes accepted problemsetQuestionList' do
      expect(response[:data]).to include(:problemsetQuestionList)
      expect(response.dig(:data, :problemsetQuestionList)).to include(:questions)
    end
  end
end
