require 'spec_helper'
require File.dirname(__FILE__) + '/../station'

describe 'Station model' do
  it 'should build a stations hash with an API response' do
    stations = Station.process(ApiResponses.single_station)
    stations.should be_an_instance_of(Hash)
    stations.first[1].should be_an_instance_of(Station)
  end

  it 'splits times between the beggining and end stations' do
    to_beginning = [1, 2, 3]
    to_end = [4, 5, 6]

    station = Station.new(to_beginning + to_end)
    station.to_beginning.should == to_beginning
    station.to_end.should == to_end
  end

  it 'should ignore times that are -1 minute' do
    station = Station.new([-1, -1, -1, -1, -1, -1])
    station.to_beginning.should be_empty
    station.to_end.should be_empty
  end

  it 'should build a hash with times splitted into both ends of the route' do
    station = Station.new([1,2,3,4,5,6])
    station.to_hash.size.should == 2
  end
end