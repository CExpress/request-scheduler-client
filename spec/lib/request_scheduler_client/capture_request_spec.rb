require 'httparty'

RSpec.describe RequestSchedulerClient::CaptureRequest do
  describe '.call' do
    context 'using HTTParty library' do
      subject do
        described_class.new.call {
          HTTParty.get('http://example.com', format: :plain, headers: {})
        }
      end

      it { expect(subject).to_not be(nil) }

      describe 'result .class' do
        it { expect(subject.class).to be(WebMock::RequestSignature) }
      end

      describe 'result .method' do
        it { expect(subject.method).to eq(:get) }
      end

      describe 'result .uri' do
        it { expect(subject.uri.class).to eq(Addressable::URI) }
      end

      describe 'result .uri.host' do
        it { expect(subject.uri.host).to eq('example.com') }
      end

      describe 'result .headers' do
        it { expect(subject.headers).to be_empty }
      end

      context 'when no request is made' do
        subject do
          described_class.new.call {
            'no request babe'
          }
        end

        it { expect { subject }.to raise_error(RuntimeError) }
      end
    end
  end
end
