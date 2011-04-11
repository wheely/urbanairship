require 'typhoeus'
require 'yajl/json_gem'

module UrbanAirship
  def self.new(application_key,application_secret)
    UrbanAirship::Client.new(application_key,application_secret)
  end
end

require 'urbanairship/client'
require 'urbanairship/device_token'