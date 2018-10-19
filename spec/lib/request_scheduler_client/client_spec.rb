require 'httparty'

RSpec.describe RequestSchedulerClient::Client do
  describe '.perform' do
    before do
      RequestSchedulerClient.setup do |config|
        config.host = 'http://testing.com'
        config.api_key = 'testingapikey'
        config.disable_webmock = false
      end
    end

    describe 'without configuration' do
      before do
        RequestSchedulerClient.reset!
      end

      it 'raises missing configuration error' do
        expect {
          described_class.new.perform do
            HTTParty.get('http://google.com')
          end
        }.to raise_error(RequestSchedulerClient::MissingConfiguration)
      end
    end

    describe 'without block' do
      it 'raises missing block error' do
        expect {
          described_class.new.perform
        }.to raise_error(RequestSchedulerClient::MissingBlock)
      end
    end

    describe 'simple request to google' do
      subject { described_class.new('2040-01-01 20:00:00') }
      let(:response_body) {
        { scheduled_at: '2040-01-01 20:00:00',
          url: 'http://google.com',
          http_method: 'get' }.to_json
      }

      it 'returns .method get' do
        stub_request(:post, "http://testing.com/api/v1/scheduled_requests.json")
          .to_return(body: response_body)

        response = subject.perform do
          HTTParty.get('http://google.com')
        end

        response = JSON.parse(response.parsed_response)

        expect(response['http_method']).to eq('get')
      end

      it 'returns .url host' do
        stub_request(:post, "http://testing.com/api/v1/scheduled_requests.json")
          .to_return(body: response_body)

        response = subject.perform do
          HTTParty.get('http://google.com')
        end

        response = JSON.parse(response.parsed_response)

        expect(response['url']).to eq('http://google.com')
      end
    end
  end
end
