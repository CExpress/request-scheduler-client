RSpec.describe RequestSchedulerClient do
  it 'has a version number' do
    expect(RequestSchedulerClient::VERSION).not_to be nil
  end

  describe '#setup' do
    before do
      RequestSchedulerClient.setup do |config|
        config.host = 'testing.com'
        config.api_key = 'testingapikey'
        config.api_version = 1
      end
    end

    it 'sets api host' do
      expect(RequestSchedulerClient.configuration.host).to eq('testing.com')
    end

    it 'sets api key' do
      expect(RequestSchedulerClient.configuration.api_key).to eq('testingapikey')
    end

    it 'sets api version' do
      expect(RequestSchedulerClient.configuration.api_version).to eq(1)
    end
  end
end
