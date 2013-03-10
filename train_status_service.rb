require './station'
require 'httparty'

class TrainStatusService
  def initialize
    app_page = HTTParty.get("http://trenes.mininterior.gov.ar/apps/web_/")
    @api_url = app_page.body.scan(/serverTrenesPath.*?"([^"]*)/).flatten.first + '1'
    @key = app_page.headers['set-cookie']
  end

  def get_status(station)
    result = HTTParty.get @api_url, headers: {'Cookie' => @key}
    ret = Station.process(result.body).each_with_object({}) {|(k,v), h| h[k] = v.to_hash}
    station ? ret[station] : ret
  end
end