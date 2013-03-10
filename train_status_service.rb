require './info_estacion'
require 'httparty'

class TrainStatusService
  def initialize
    app_page = HTTParty.get("http://trenes.mininterior.gov.ar/apps/web_/")
    @api_url = app_page.body.scan(/serverTrenesPath.*?"([^"]*)/).flatten.first + '1'
    @key = app_page.headers['set-cookie']
  end

  def self.get_status(estacion)
    self.new.get_status(estacion)
  end

  def get_status(estacion)
    result = HTTParty.get @api_url, headers: {'Cookie' => @key}
    ret = InfoEstacion.process(result.body)
    estacion ? ret[estacion] : ret
  end
end