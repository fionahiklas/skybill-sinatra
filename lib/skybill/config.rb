require 'yaml'

require 'util/lumber'
require 'util/yamlEnvironmentParser'


module Skybill

  module Constants
    CONFIG_SKYBILL = 'skybill'
    CONFIG_REST_URL = 'url'
    CONFIG_SCHEMA = 'schema'
  end


  ##
  #
  # Holds all of the configuration details for the Server
  #
  class Config

    include Util::Lumber::LumberJack

    @@log = lumber("Config")

    include Skybill::Constants

    CONFIG_ENV = 'SKYBILL_CONFIG_FILENAME'
    DEFAULT_CONFIG_FILENAME = 'conf/skybill-server-development.yaml'

    CONFIG_FILE_PATH_BASE = 'conf/skybill-server-'
    CONFIG_FILE_PATH_EXTENSION = '.yaml'

    RACK_ENVIRONMENT = 'RACK_ENV'

    DEFAULT_MINIMUM_LENGTH = 10
    DEFAULT_MAXIMUM_LENGTH = 8000
    DEFAULT_LINE_LENGTH = 80


    def initialize
      load_configuration
    end

    def schema
      skybill_config(CONFIG_SCHEMA)
    end

    def url
      skybill_config(CONFIG_REST_URL)
    end


    private

      def load_configuration
        # This must be passed in using rackup -e "\$configFilename='<filename>'"
        configFilename = config_filename

        @@log.debug('Loading yaml config from "%s" ...', configFilename)

        @config = Util::YamlEnvironmentParser.parse(File.read(configFilename))

        @@log.debug('... loaded')
      end


      def calculate_config_filename
        rack_environment = ENV[RACK_ENVIRONMENT]
        if rack_environment.nil?
          @@log.debug('No rack environment set, defaulting filename')
          DEFAULT_CONFIG_FILENAME
        else
          @@log.debug('Using rack environment setting: %s', rack_environment)
          "#{CONFIG_FILE_PATH_BASE}#{rack_environment}#{CONFIG_FILE_PATH_EXTENSION}"
        end
      end


      ##
      #
      # We need a bootstrap for this filename to load our config
      #
      def config_filename
        ENV[CONFIG_ENV] || calculate_config_filename
      end


      def skybill_config(key)
        value = @config[CONFIG_SKYBILL][key]
        @@log.debug('Email send config, key=%s, value=%s', key, value)
        value
      end

      def environment_config(key)
        ENV[key]
      end

  end

end