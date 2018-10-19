module RequestSchedulerClient
  class CaptureRequest
    def call &block
      WebMock.enable!

      request = nil

      begin
        yield if block_given?
      rescue WebMock::NetConnectNotAllowedError => e
        request = e.request_signature
      end

      if RequestSchedulerClient.configuration.disable_webmock
        WebMock.disable!
      end

      request || (raise RuntimeError.new("No request was made"))
    end
  end
end
