$:.unshift File.expand_path("./lib", File.dirname(__FILE__))

require 'skybill/server'

use Rack::Static, :urls => ['/html', '/javascript', '/css'], :root => 'public'

run Skybill::Server
