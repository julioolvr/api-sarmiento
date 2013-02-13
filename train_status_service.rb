require 'net/http'
require './info_estacion'

class TrainStatusService
  def initialize
    uri = URI("http://trenes.mininterior.gov.ar/apps/web_/")
    http = Net::HTTP.new(uri.host, uri.port)
    result = http.get(uri.path)
    @api_url = result.body.scan(/serverTrenesPath.*?"([^"]*)/).flatten.first + '1'
    @key = result.to_hash['set-cookie'].first
  end

  def self.get_status(estacion)
    self.new.get_status(estacion)
  end

  def get_status(estacion)
    uri = URI(@api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    result = http.get(@api_url, {'Cookie' => @key})
    ret = InfoEstacion.process(result.body)
    estacion ? ret[estacion] : ret
  end
end