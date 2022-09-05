# frozen_string_literal: true

RSpec.describe Leetcoder::Download do
  describe '#call', :vcr do
    let(:response) { described_class.call }

    it 'downloads all accepted submissions' do
      expect(response).to be_truthy
    end
  end
end
