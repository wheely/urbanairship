require 'uri'

module UrbanAirship
  class Client
    @@base_uri = 'https://go.urbanairship.com'
    
    def self.base_uri
      @@base_uri
    end
    
    def initialize(application_key,application_master_secret)
      @application_key = application_key
      @application_master_secret = application_master_secret
    end
    
    def device_tokens(device_token, opts={})
      put("/api/device_tokens/#{device_token}", :body => opts)
      true
    end
    
    def get_device_token(device_token)
      data = get("/api/device_tokens/#{device_token}")
      return UrbanAirship::DeviceToken.new(self,data)
    end
    
    def push(opts={})
      post("/api/push/", :body => opts)
    end
    
    private
    
    def get(url, params={})
      request(url, params.merge(:method => :get))
    end
    def put(url, params={})
      request(url, params.merge(:method => :put))
    end
    def post(url, params={})
      request(url, params.merge(:method => :post))
    end
    
    def request(url, params)
      params[:method] ||= :get
      params[:username] = @application_key
      params[:password] = @application_master_secret
      params[:proxy] = "localhost:8888"
      if params[:body]
        params[:headers] ||= { :'Content-Type' => 'application/json'}
        params[:body] = params[:body].to_json
      end
      response = Typhoeus::Request.run(URI.escape("#{@@base_uri}#{url}"), params)
      return parse_response(response)
    end
    
    def parse_response(response)
      unless [200,201,204].any?{|status| status == response.code}
        raise UrbanAirshipError.new('Unknown error', response.code)
      end
      unless response.headers_hash['Content-Type'] =~ /application\/json/
        return {}
      end
      data = Yajl::Parser.parse(response.body)
      return data
    end
    
  end
end

class UrbanAirshipError < StandardError
  attr_reader :code
  alias :msg :message
  def initialize(msg,code)
    @code = code
    super("#{msg} - '#{code}'")
  end
end