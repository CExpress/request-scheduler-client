require 'webmock'
require 'webmock/net_connect_not_allowed_error'
require 'request_scheduler_api/version'
require 'request_scheduler_api/client'
require 'request_scheduler_api/capture_request'

module RequestSchedulerClient
  class Configuration
    DEFAULT_API_VERSION = 1

    attr_accessor :host, :api_key, :api_version

    def api_version
      DEFAULT_API_VERSION
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.setup
    yield(configuration)
  end
end
