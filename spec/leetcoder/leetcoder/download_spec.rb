# frozen_string_literal: true

RSpec.describe Leetcoder::Download do
  describe '#call', :vcr do
    let(:response) { described_class.call }

    it 'downloads all accepted submissions' do
      allow(File).to receive(:write).and_return(true)
      allow(FileUtils).to receive(:mkdir_p).and_return(['leetcoder_test_dir'])
      allow(Dir).to receive(:chdir).and_return(true)

      expect(response).to be_truthy
    end
  end
end
