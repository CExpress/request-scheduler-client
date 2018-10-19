require 'httparty'

module RequestSchedulerClient
  class Client
    attr_reader :scheduled_at

    def initialize scheduled_at = nil
      @scheduled_at = scheduled_at
    end

    def perform &block
      raise MissingConfiguration.new unless RequestSchedulerClient.configured?
      raise MissingBlock.new if block.nil?

      request = capture_request.call &block

      HTTParty.post(endpoint,
                    headers: {'Content-Type': 'application/json'},
                    query: {
                      api_key: api_key,
                      scheduled_request: {
                        scheduled_at: scheduled_at,
                        http_method: request.method,
                        uri: request.uri.to_s,
                        body: request.body,
                        headers: request.headers.to_json
                      }
                    })
    end

    protected

    def endpoint
      "#{host}/api/v#{api_version}/scheduled_requests.json"
    end

    def api_key
      RequestSchedulerClient.configuration.api_key
    end

    def host
      RequestSchedulerClient.configuration.host
    end

    def api_version
      RequestSchedulerClient.configuration.api_version
    end

    def capture_request
      CaptureRequest.new
    end
  end
end
