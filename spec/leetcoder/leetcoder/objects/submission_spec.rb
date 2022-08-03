# frozen_string_literal: true

RSpec.describe Leetcoder::Submission do
  let!(:submission_obj) do
    vcr 'submission' do
      Leetcoder::SubmissionsResource.new.retrieve(url: 'submissions/detail/754052092/')
    end
  end
  let!(:instance) { described_class.new(submission_obj) }

  describe '.save_to_file!' do
    it 'creates a new file with the question data' do
      allow(File).to receive(:write).with('15.solution.rb', instance.code).and_return(true)
      response = instance.save_to_file!

      expect(response).to be_truthy
    end
  end
end
