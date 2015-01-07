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

  get '/committees' do
    content_type :json
    committee_id = params[:committee_id] || ""
    status = params[:status] || "40"
    JSON.parse(search(committee_id: committee_id, status: status)).to_json
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
    committee_id = params[:committee_id] || ""
    status = params[:status] || "0"
    start_date = params[:start_date] || ""
    council_period = params[:council_period] || "21"
  	JSON.parse(search(q: q, measure_type: measure_type, committee_id: committee_id, status: status, start_date: start_date, council_period: council_period)).to_json
  end

  run! if app_file == $0

end
