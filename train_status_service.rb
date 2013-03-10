require './station'
require 'httparty'

class TrainStatusService
  def initialize
    app_page = HTTParty.get("http://trenes.mininterior.gov.ar/apps/web_/")
    @api_url = app_page.body.scan(/serverTrenesPath.*?"([^"]*)/).flatten.first + '1'
    @key = app_page.headers['set-cookie']
  end

  def self.get_status(station)
    self.new.get_status(station)
  end

  def get_status(station)
    result = HTTParty.get @api_url, headers: {'Cookie' => @key}
    ret = Station.process(result.body)
    station ? ret[station] : ret
  end
end