
require 'mocks/mock_config'


class MockClient

  attr_accessor :next_response, :getbill_called

  def initialize(config)
    # Do nothing
  end

  def getbill
    @getbill_called = true
    @next_response
  end
end


module Skybill

  class Server

    def self.create_config
      MockConfig.new
    end

    def self.create_client
      MockClient.new(Server::config)
    end

  end

end