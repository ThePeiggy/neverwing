require 'rest-client'
require 'json'

require_relative 'lib/config'
require_relative 'lib/data'
require_relative 'lib/schema'
require_relative 'lib/play'
require_relative 'lib/dragons'
require_relative 'lib/store'
require_relative 'lib/evolve'

class Neverwing
  attr_accessor :login_url

  LOGIN_PATH = '/auth'.freeze
  LISTING_PATH = '/purchase/listing'.freeze

  def initialize(login_url)
    @login_url = login_url
    reload
  end

  def reload
    load_config
    load_data
    load_schema
  end
end
