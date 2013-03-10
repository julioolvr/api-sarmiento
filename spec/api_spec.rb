require 'spec_helper'
require 'rack/test'
require 'json'
require File.dirname(__FILE__) + '/../api'

ENV['RACK_ENV'] = 'test'

describe 'API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before(:each) do
    @station_name = 'station1'
    mocked_stations = {@station_name => {to: [], from: []}, 'station2' => {to: [], from: []}, 'station3' => {to: [], from: []}}

    TrainStatusService.any_instance.stub(:initialize)
    TrainStatusService.any_instance.stub(:get_status) do |station|
      station ? mocked_stations[station] : mocked_stations
    end
  end

  it "GET / should return data for all train stations" do
    get '/'
    JSON.parse(last_response.body).size.should > 1
  end

  it "GET /some_station should return data only for some_station" do
    get "/#{@station_name}"
    JSON.parse(last_response.body).size.should == 2
  end

  it "GET /non_existent_station should return a 404" do
    get '/nope'
    last_response.should be_not_found
  end
end