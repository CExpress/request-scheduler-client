require 'webmock'
require 'webmock/net_connect_not_allowed_error'
require 'request_scheduler_client/version'
require 'request_scheduler_client/client'
require 'request_scheduler_client/capture_request'

module RequestSchedulerClient
  class MissingConfiguration < ::RuntimeError
    def initialize
      @message = 'You need to setup the gem using `RequestSchedulerClient.setup`'
    end
  end

  class MissingBlock < ::RuntimeError; end

  class Configuration
    DEFAULT_API_VERSION = 1

    attr_accessor :host, :api_key, :api_version, :disable_webmock

    def initialize
      @disable_webmock = true
    end

    def api_version
      DEFAULT_API_VERSION
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset!
    @configuration = Configuration.new
  end

  def self.configured?
    configuration.host && configuration.api_key && configuration.api_version
  end

  def self.setup
    yield(configuration)
  end
end
