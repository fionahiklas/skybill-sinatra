
require 'test/unit'

require 'util/lumber'
require 'skybill/client'

require 'mocks/for_client_tests'

##
#
# Test the client code
class ClientTest < Test::Unit::TestCase

  include Util::Lumber::LumberJack

  @@log = lumber('ClientTest')

  TEST_SIMPLE_URL = 'http://terry.practchett.discworld.am'
  TEST_SIMPLE_RESPONSE_BODY = '{ "skybill" : { "name" : "Moist Von Lipwig" } }'


  def before_setup
    super
    @client = create_client
    @@log.debug("Running before test")
  end

  def after_teardown
    super
  end

  def test_simple_response
    @@log.debug('Testing simple response')

    @config.url = TEST_SIMPLE_URL
    setup_simple_json_response

    response = @client.getbill

    last_url = MockRestClient::last_url
    assert_equal(TEST_SIMPLE_URL, last_url, 'Last url should be the test value we set')

    assert_equal(Rack::Response, response.class, 'Check that this is the right class')
    assert_equal(200, response.status, 'Should have a status of 200')
    assert_equal(TEST_SIMPLE_RESPONSE_BODY, response.body[0], 'Last response should have been the value we set' )
  end


  def test_simple_response_convert_content_type
    @@log.debug('Testing simple response')

    @config.url = TEST_SIMPLE_URL
    setup_simple_json_response

    response = @client.getbill

    last_url = MockRestClient::last_url
    assert_equal(TEST_SIMPLE_URL, last_url, 'Last url should be the test value we set')

    assert_equal(200, response.status, 'Should have a status of 200')

    contentType = response['Content-Type']
    assert_not_nil(contentType, 'The Content-Type header should exist')
    assert_equal('application/json', contentType, 'Content type should be JSON' )
  end

  private

  def create_client
    @@log.debug("Returning client instance")

    @config = MockConfig.new
    Skybill::Client.new(@config)
  end

  def setup_simple_json_response
    response = MockRestClientResponse.new
    response.code = 200
    response.headers = { :content_type => 'application/json' }
    response.body = TEST_SIMPLE_RESPONSE_BODY
    MockRestClient::next_response = response
  end

end

