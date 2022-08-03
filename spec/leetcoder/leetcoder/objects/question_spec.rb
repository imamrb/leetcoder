# frozen_string_literal: true

RSpec.describe Leetcoder::Question do
  let!(:question_obj) do
    vcr 'question' do
      Leetcoder::QuestionsResource.new.retrieve('two-sum')
    end
  end
  let!(:instance) { described_class.new(question_obj) }

  describe '.save_to_file!' do
    it 'creates a new file with the question data' do
      allow(File).to receive(:write).with('README.md', instance.question_data).and_return(true)
      response = instance.save_to_file!

      expect(response).to be_truthy
    end
  end

  describe '.question_data' do
    it 'returns the question data' do
      expect(instance.question_data).to be_a(String)
    end
  end

  describe '.serialized_data' do
    it 'returns the serialized data' do
      data = instance.serialized_data

      expect(data).to be_a(Hash)
      expect(data).to include(*%i[title url topic_tags content stats])
    end
  end

  describe '.stats' do
    it 'returns the question stats' do
      data = instance.stats

      expect(data).to be_a(String)
      expect(data).to match(/ACRATE/i)
    end
  end
end
