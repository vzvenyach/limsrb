require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/contrib/all'
require 'github/markup'
require 'redcarpet'
require 'json'
require 'mongo'
require './lims'

include Mongo

class App < Sinatra::Base
  # register Sinatra::Contrib
  # register Sinatra::ActiveRecordExtension

  mongoHost = ENV.fetch('MONGOHOST', 'localhost')
  mongoPort = ENV.fetch('MONGOPORT', 27017)
  mongoDB = ENV.fetch('MONGODB', 'limsydb')
  mongoColl = ENV.fetch('MONGOCOLLECTION', 'measures')
  mongoUser = ENV.fetch('MONGOUSER', '')
  mongoPwd = ENV.fetch('MONGOPWD', '')

  conn = MongoClient.new(mongoHost, mongoPort)
  db = conn[mongoDB]
  auth = db.authenticate(mongoUser, mongoPwd)

  before do
    response['Access-Control-Allow-Origin'] = "*"
  end

  get '/' do
    redirect('index.html')
  end
  
  get '/measure/:measure' do
     
    if params["measure"].split('-')[0][1,2].to_i < 20
      # If we're here, that means we're using Mongo to output information
      return db[mongoColl].find_one(:LegislationNo => params["measure"]).to_json
    else
    	content_type :json
    	JSON.parse(get_measure(params["measure"])).to_json
    end
  end

  get '/committees' do
    content_type :json
    measure_type = params[:measure_type] || "1"
    committee_id = params[:committee_id] || ""
    status = params[:status] || "40"
    council_period = params[:council_period] || "21"
    JSON.parse(search(committee_id: committee_id, council_period: council_period, measure_type: measure_type, status: status)).to_json
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
