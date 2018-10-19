require 'byebug'
require 'httparty'

RSpec.describe RequestSchedulerClient::Client do
  describe '.perform' do
    describe 'without configuration' do
      it 'raise exception' do
        expect {
          described_class.new.perform do
            HTTParty.get('http://google.com')
          end
        }.to raise_error()
      end
    end
  end
end
