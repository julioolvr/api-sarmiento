require 'sinatra'
require 'sinatra/jsonp'
require './train_status_service'

get '/:estacion?' do
  JSONP TrainStatusService.new.get_status(params[:estacion])
end