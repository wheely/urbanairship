require 'typhoeus'
require 'yajl/json_gem'

module UrbanAirship
  def self.new(application_key,application_secret, device_type = "ios")
    UrbanAirship::Client.new(application_key,application_secret, device_type)
  end
end

require 'urbanairship/client'
require 'urbanairship/device_token'
