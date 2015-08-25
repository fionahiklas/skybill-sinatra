$:.unshift File.expand_path("./lib", File.dirname(__FILE__))

require 'skybill/server'

urls = ['/html', '/javascript', '/css', '/qunit']

use Rack::Static, :urls => urls, :root => 'public'

run Skybill::Server
