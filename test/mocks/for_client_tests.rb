require 'mocks/mock_config'

##
#
# Simple mock RestClient that will allow us to inject responses and
# also capture the last URL that was passed into the client
#
module MockRestClient

  include Util::Lumber::LumberJack

  @@log = lumber('MockRestClient')

  def self.get(url)
    @@log.debug('Get url: %s', url)
    @@last_url = url
    @@log.debug('Returning response: %s', @@next_response)
    @@next_response
  end

  def self.last_url
    @@last_url
  end

  def self.last_url=(last_url)
    @@last_url = last_url
  end

  def self.next_response=(responseToReturn)
    @@next_response = responseToReturn
  end
end


module Skybill

  ##
  #
  # Override the client so that it uses a MockRest client
  #
  class Client

    include Util::Lumber::LumberJack

    @@log = lumber('ClientOverride')

    private

    def rest_client
      @@log.debug('Returning mock rest client')
      MockRestClient
    end

  end

end
