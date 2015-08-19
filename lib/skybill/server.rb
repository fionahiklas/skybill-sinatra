require 'sinatra/base'

require 'util/lumber'

require 'skybill/config'
require 'skybill/responseGenerator'


##
#

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

		##
		#
		# Configure the Sinatra Application
		#
		# This is called before any other code is parsed in this class.  This means
		# that we can only call class methods that have already been defined before this
		# point.
		#
		configure do

			@@config = Config.new


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


		not_found do
			@@log.debug('Not found')
			generate_error_response(404, "Resource '#{request.fullpath}' not found")
		end


		error do
			@@log.error('Application error')
			generate_error_response(500, 'Application error')
		end


		private

			def read_request_body(body_stringio)
				@@jsonHandler.read_request_body(body_stringio)
			end


			def validate_json(json_text)
				@@jsonHandler.validate_json(json_text)
			end


			def generate_form(json_hash)
				@@emailHandler.generate_form(json_hash)
			end


			def create_email(parsed_data)
				@@emailHandler.create_email(parsed_data)
			end


			def send_email(email_data)
				@@emailHandler.send_email(email_data)
			end

	end

end

