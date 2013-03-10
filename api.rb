require 'sinatra'
require 'sinatra/jsonp'
require './train_status_service'

get '/:station?' do
  train_status = TrainStatusService.new.get_status(params[:station])

  if train_status
    JSONP train_status
  else
    status 404
  end
end