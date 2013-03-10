require 'sinatra'
require 'sinatra/jsonp'
require './train_status_service'

get '/:station?' do
  JSONP TrainStatusService.new.get_status(params[:station])
end