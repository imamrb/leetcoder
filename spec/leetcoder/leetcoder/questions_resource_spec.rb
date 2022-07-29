# frozen_string_literal: true

RSpec.describe Leetcoder::QuestionsResource do
  let!(:instance) { described_class.new }

  describe '.list' do
    let!(:response) do
      vcr 'questions' do
        instance.list
      end
    end

    it 'returns questions list' do
      expect(response).to be_a Array
      expect(response.first.frontendQuestionId).to eq('1')
    end
  end

  describe '.retrieve' do
    let!(:response) do
      vcr 'question' do
        instance.retrieve('two-sum')
      end
    end

    it 'returns a single question' do
      expect(response.questionId).to eq('1')
    end
  end
end

