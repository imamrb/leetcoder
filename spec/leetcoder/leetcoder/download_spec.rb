# frozen_string_literal: true

RSpec.describe Leetcoder::Download do
  describe '#download_ac_submissions', :vcr do
    let(:response) { described_class.download_ac_submissions }

    it 'downloads all accepted submissions' do
      allow(File).to receive(:write).and_return(true)
      allow(FileUtils).to receive(:mkdir_p).and_return(['leetcoder_test_dir'])
      allow(Dir).to receive(:chdir).and_return(true)

      expect(response).to be_truthy
    end
  end
end
