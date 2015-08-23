
require 'test/unit'
require 'rack/test'

require 'util/lumber'
require 'skybill/server'

require 'mocks/for_server_tests.rb'


class ServerAppTest < Test::Unit::TestCase

  include Util::Lumber::LumberJack

  @@log = lumber("ServerAppTest")

  TEST_SIMPLE_RESPONSE = '{ "skybill" : { "name" : "Moist Von Lipwig" } }'

  include Rack::Test::Methods

  def app
    @@log.debug("Returning server instance")
    Skybill::Server.new
  end

  def before_setup
    super
    @@log.debug("Running before test")
  end

  def after_teardown
    super
  end

  def test_status
    @@log.debug('Testing status')
    get '/status'
    assert_equal '{ "status" : "Testing status" }', last_response.body
  end

  def test_get_bill_got_200
    @@log.debug('Simple get bill')

    set_simple_json_response_from_client
    get '/getbill'

    assert_equal(200, last_response.status, 'The last response should have been 200')
  end

  def test_get_bill_content_type_json
    @@log.debug('Simple get bill')

    set_simple_json_response_from_client
    get '/getbill'

    assert_equal('application/json', last_response['ContentType'], 'The last response should have JSON content type')
  end


  def set_simple_json_response_from_client
    mockClient = Skybill::Server::client

    headers = {
        'contentType' => 'application/json'
    }
    mockResponse = Rack::MockResponse.new( 200, headers, TEST_SIMPLE_RESPONSE)
    mockClient.next_response = mockResponse
  end

end

