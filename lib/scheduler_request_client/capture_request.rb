module RequestSchedulerClient
  class CaptureRequest
    def call
      WebMock.enable!

      request = nil

      begin
        yield if block_given?
      rescue WebMock::NetConnectNotAllowedError => e
        request = e.request_signature
      end

      WebMock.disable!

      request || (raise RuntimeError.new("No request was made"))
    end
  end
end
