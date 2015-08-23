
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
  TEST_SIMPLE_RESPONSE = '{ "skybill" : { "name" : "Moist Von Lipwig" } }'


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
    MockRestClient::next_response = TEST_SIMPLE_RESPONSE

    response = @client.getbill

    last_url = MockRestClient::last_url
    assert_equal(TEST_SIMPLE_URL, last_url, 'Last url should be the test value we set')
    assert_equal(TEST_SIMPLE_RESPONSE, response, 'Last response should have been the value we set' )
  end

  private

  def create_client
    @@log.debug("Returning client instance")

    @config = MockConfig.new
    Skybill::Client.new(@config)
  end


end

