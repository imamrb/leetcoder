# frozen_string_literal: true

RSpec.describe Leetcoder::SubmissionsResource do
  let!(:instance) { described_class.new(title_slug: 'two-sum') }

  describe '.list' do
    let!(:response) do
      vcr 'submissions' do
        instance.list
      end
    end

    it 'returns submissions list' do
      expect(response).to be_a Array
    end
  end

  describe '.accepted_list' do
    let!(:response) do
      vcr 'submissions' do
        instance.accepted_list
      end
    end
    let(:uniq_status) { response.map { |x| x[:statusDisplay] }.uniq }

    it 'returns submissions accepted list' do
      expect(uniq_status.count).to eq(1)
      expect(uniq_status.first).to eq('Accepted')
    end
  end

  describe '.retrieve' do
    let!(:response) do
      vcr 'submission' do
        instance.retrieve(url: 'submissions/detail/754052092/')
      end
    end

    it 'returns a single submission data' do
      expect(response).to be_a(Nokogiri::HTML4::Document)
      expect(response.search('script').text.scan(/submissionCode/).first).to eq('submissionCode')
    end
  end
end
