require 'rack'
require 'rack/response'
require 'rest-client'
require 'util/lumber'


module Skybill

  ##
  #
  # Rest client to retrieve the JSON from the Skybill endpoint
  #
  # Using a class so that the functionality can be encapsulated for easy
  # testing.
  #
  # This class also needs to translate between RestClient responses and
  # Rack::Response.  The server expects the latter as it makes it really easy
  # to pass the response back to the calling webclient.  The RestClient module
  # returns it's own format and doesn't seem to support Rack.
  #
  class Client

    include Util::Lumber::LumberJack

    @@log = lumber('Client')

    ##
    #
    # Some of the header symbols that RestClient returns need mapping to
    # string header names.  This is a look-up table for important mappings
    #
    SYMBOL_STRING_HEADER_MAPPING = {
        :content_type => 'Content-Type'
    }


    ##
    #
    # Config object is needed to get the URL to call
    #
    def initialize(config)
      @config = config
    end


    ##
    #
    # Get the bill JSON from the URL in the configuration
    #
    def getbill
      url_to_call = @config.url
      rest_client_response = rest_client.get(url_to_call)
      @@log.debug('Got code: %s, headers: %s', rest_client_response.code, rest_client_response.headers)

      Rack::Response.new([ rest_client_response.body ],
                         rest_client_response.code,
                         convert_headers(rest_client_response.headers))
    end

    private

    ##
    #
    # RestClient is actually a module which is a bit weird to return as
    # you'd expect objects.  But a module is an object in Ruby :)
    #
    def rest_client
      @@log.debug('Return rest client')
      RestClient
    end


    ##
    #
    # The RestClient returns headers as symbols rather than text,
    # convert these into string keys
    #
    def convert_headers(rest_client_headers)
      rack_headers = {}
      rest_client_headers.each do |key, value|
        rack_header_key = check_mapping(key)
        rack_headers[rack_header_key] = value
      end

      rack_headers
    end

    def check_mapping(key_to_check)
      SYMBOL_STRING_HEADER_MAPPING[key_to_check] || key_to_check.to_s
    end
  end

end