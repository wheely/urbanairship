require 'spec_helper'

describe UrbanAirship::Client do
  before(:each) do
    @client = UrbanAirship::Client.new('wopsi','dupsi')
  end
  describe "#device_tokens" do
    it "should register a valid device" do
      @client.should_receive(:request).and_return({})
      result = @client.device_tokens('420958A717C04756A37851A8667C69637604F59DF1D23B3C91720051D73A096B', :alias => '123f')
      result.should == true
    end
    it "should raise an error if the credentials or token are invalid" do
      @client.should_receive(:request).and_raise(UrbanAirshipError.new('unauthorized',401))
      lambda {@client.device_tokens('not a token')}.should raise_error
    end
  end
  describe "#get_device_token" do
    it "should retrieve a valid token" do
      response = {
          "device_token" => "420958A717C04756A37851A8667C69637604F59DF1D23B3C91720051D73A096B", 
          "last_registration" => "2011-04-11 10:20:50", 
          "tz" => nil, 
          "tags" => [], 
          "alias" => "123f", 
          "quiettime" => {
              "start" => nil, 
              "end" => nil
          }, 
          "active" => true, 
          "badge" => 0
      }
      @client.should_receive(:request).and_return(response)
      device_token = @client.get_device_token('420958A717C04756A37851A8667C69637604F59DF1D23B3C91720051D73A096B')
      device_token.alias.should == '123f'
    end
    it "should raise an error if id or credentials are invalid" do
      @client.should_receive(:request).and_raise(UrbanAirshipError.new('unauthorized',401))
      lambda  {@client.get_device_token('pumpump') }.should raise_error
    end
  end
  describe "#push" do
    it "should send a push notification" do
      @client.should_receive(:request).and_return(nil)
      result = @client.push(:aliases => ['lol'], :aps => { :badge => 1, :alert => 'hello'})
    end
  end
end