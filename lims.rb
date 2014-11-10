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
	conn = Faraday.new(:url => 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/LatestLaw') do |faraday|
	  faraday.request  :url_encoded             # form-encode POST params
	  faraday.response :logger                  # log requests to STDOUT
	  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	end

	body = {:count => count }

	response = conn.post do |req|
	  req.url 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/LatestLaw'
	  req.headers['Content-Type'] = 'application/json'
	  req.body = body.to_json
	end
	return JSON.parse(response.body)['d']
end

def search (q:'', measure_type: '', member_id: '')
	
	search_string = "|" + measure_type + "|||20|" + member_id + "|||||||" + q + "|||0|false"

	conn = Faraday.new(:url => 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/GetPublicAdvancedSearch') do |faraday|
	  faraday.request  :url_encoded             # form-encode POST params
	  faraday.response :logger                  # log requests to STDOUT
	  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	end

	body = {:inputJSON => search_string }

	response = conn.post do |req|
	  req.url 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/GetPublicAdvancedSearch'
	  req.headers['Content-Type'] = 'application/json'
	  req.body = body.to_json
	end
	return JSON.parse(response.body)['d']
end