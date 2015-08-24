require 'sinatra/base'

require 'util/lumber'

require 'skybill/config'
require 'skybill/client'
require 'skybill/responseGenerator'


##
#
# All Skybill code should be under this namespace to keep things clean and tidy
#
module Skybill

	##
	#
	# Application class for Skybill server
	#
	#
	class Server < Sinatra::Base

		include Util::Lumber::LumberJack

		@@log = lumber("Server")

		include Skybill::ResponseGenerator

		def initialize
			super
			@@log.debug('Server Instance created')
		end

		def self.create_config
			Skybill::Config.new
		end

		def self.create_client
			Skybill::Client.new(Server::config)
		end

		def self.config
			@@config ||= Server::create_config
		end

		def self.client
			@@client ||= Server::create_client
		end

		##
		#
		# Configure the Sinatra Application
		#
		# This is called before any other code is parsed in this class.  This means
		# that we can only call class methods that have already been defined before this
		# point.
		#
		# Any configuration or resources for the application need to be class members as
		# Rack creates instances to handle requests.  There isn't a way to create an
		# instance to handle things, this is left up to Rack and the web server
		# implementation.  We're not in Java land anymore Toto ;-)
		#
		configure do

			if settings.development?
				@@log.debug('** Development **')
			end

			if settings.test?
				@@log.debug('** Test **')
			end

			if settings.production?
				@@log.debug('** Production **')
			end

			# Avoids returning big HTML rendered pages with stack traces when we get an error
			set :show_exceptions, false

			@@log.debug('... configured!')
		end


		get '/status' do
			@@log.debug('Status')

			returnJson = '{ "status" : "Testing status" }'
			[ 200, returnJson ]
		end


		get '/getbill' do
			@@log.debug('Getbill')
			response = Server::client.getbill

			# Check schema here using json-schema

			@@log.debug('Got response, status code: %s, headers: %s', response.status, response.headers)
			[ response.status, response.headers, response.body]
		end

		not_found do
			@@log.debug('Not found')
			generate_error_response(404, "Resource '#{request.fullpath}' not found")
		end


		error do
			@@log.error('Application error')
			generate_error_response(500, 'Application error')
		end

	end

end

