require "faraday"
require 'json'

def get_measure (measure)

	conn = Faraday.new(:url => 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/GetPublicData') do |faraday|
	  faraday.request  :url_encoded             # form-encode POST params
	  faraday.response :logger                  # log requests to STDOUT
	  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	end

	body = {:legislationId => measure }

	response = conn.post do |req|
	  req.url 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/GetPublicData'
	  req.headers['Content-Type'] = 'application/json'
	  req.body = body.to_json
	end
	return JSON.parse(response.body)['d']
end

def get_laws (count)
	pass
end

def search ()
	pass
end