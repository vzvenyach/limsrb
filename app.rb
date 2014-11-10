require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/contrib/all'
require 'github/markup'
require 'redcarpet'
require 'json'
require './lims'

class App < Sinatra::Base
  # register Sinatra::Contrib
  # register Sinatra::ActiveRecordExtension

  before do
    response['Access-Control-Allow-Origin'] = "*"
  end

  get '/' do
    "Hello World"
  end
  
  get '/measure/:measure' do
  	content_type :json
  	JSON.parse(get_measure(params["measure"])).to_json
  end

  get '/laws' do
  	content_type :json
  	count = params[:count] || "10"
  	JSON.parse(get_laws(count)).to_json
  end

  get '/search' do
  	content_type :json
  	q = params[:q] || ""
  	measure_type = params[:measure_type] || ""
  	JSON.parse(search(q: q, measure_type: measure_type)).to_json
  end

  run! if app_file == $0

end
