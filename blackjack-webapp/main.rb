require 'rubygems'
require 'sinatra'

set :sessions, true

get '/render' do
  erb :'render/rendering'

end



