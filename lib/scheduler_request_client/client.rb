module RequestSchedulerClient
  class Client
    attr_reader :requests

    def perform
      check_configuration
    end

    protected
  end
end
