
require 'test/unit'
require 'rack/test'

require 'util/lumber'
require 'skybill/server'


class ServerAppTest < Test::Unit::TestCase

  include Util::Lumber::LumberJack

  @@log = lumber("ServerAppTest")

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

end

