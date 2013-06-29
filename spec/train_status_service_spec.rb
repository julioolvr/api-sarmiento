require 'spec_helper'
require 'test_helpers'
require File.dirname(__FILE__) + '/../train_status_service'

describe "Train status service" do
  describe "real service check" do
    it "is returning a valid response" do
      WebMock.allow_net_connect!
      service = TrainStatusService.new.get_status(nil).should_not be_nil
    end
  end

  describe "mocked service" do
    before(:each) do
      @api_url = 'http://www.sampleapiurl.com/'
      body = <<-response_body
        var serverTrenesPath = "#{@api_url}";
      response_body
      @cookie = 'COOKIE!'
      stub_request(:any, 'http://trenes.mininterior.gov.ar/apps/web_/').to_return(body: body, headers: {'set-cookie' => @cookie})
    end

    it "should set the API url and cookie from the app" do
      service = TrainStatusService.new
      service.instance_variable_get(:@key).should == @cookie
      service.instance_variable_get(:@api_url).should =~ /#{@api_url}/
    end

    describe "station statuses" do
      before(:each) do
        @station_name = 'station1'
        mocked_stations = {@station_name => {to: [], from: []}, 'station2' => {to: [], from: []}, 'station3' => {to: [], from: []}}
        Station.stub(process: mocked_stations)

        @service = TrainStatusService.new
        stub_request(:any, @service.instance_variable_get(:@api_url))
      end

      it "should return the status for all stations if it gets a nil parameter" do
        status = @service.get_status(nil)
        status.size.should > 1
      end

      it "should return the status of a single station if it gets its name" do
        status = @service.get_status(@station_name)
        status.size.should == 2
      end
    end
  end
end