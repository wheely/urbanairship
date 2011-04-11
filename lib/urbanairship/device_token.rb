module UrbanAirship
  class DeviceToken
    attr_accessor :alias
    
    def initialize(client, opts={})
      @client = client
      if opts
        @alias = opts['alias']
      end
    end
    
  end
end