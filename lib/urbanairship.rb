require 'yajl/json_gen'

module UrbanAirship
  def self.new(opts={})
    UrbanAirship::Client.new(opts)
  end
end

require 'urbanairship/client'