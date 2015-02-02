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

def get_file()
	pass
end

def search (q:'', measure_type: '', member_id: '', committee_id: '', status: '0', start_date: '', council_period: '')
	
	# search_string = "|" + measure_type + "|||" + council_period + "|" + member_id + "||" + committee_id.to_s + "||" + start_date + "||100|" + q + "|||" + status + "|false"


	conn = Faraday.new(:url => 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/GetPublicAdvancedSearch') do |faraday|
	  faraday.request  :url_encoded             # form-encode POST params
	  faraday.response :logger                  # log requests to STDOUT
	  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
	end

	# body = {:inputJSON => search_string }
	body = {:criteria=>{:Keyword=>q,:Category=>measure_type,:SubCategoryId=>"",:RequestOf=>"",:CouncilPeriod=>council_period,:Introducer=>member_id,:CoSponsor=>"",:ComitteeReferral=>committee_id,:CommitteeReferralComments=>"",:StartDate=>start_date,:EndDate=>"",:QueryLimit=>100,:FilterType=>"",:Phases=>"",:LegislationStatus=>status,:IncludeDocumentSearch=>false}, :request=>{:sEcho=>1,:iColumns=>4,:sColumns=>"",:iDisplayStart=>0,:iDisplayLength=>10,:mDataProp_0=>"ShortTitle",:mDataProp_1=>"Title",:mDataProp_2=>"LegislationCategories",:mDataProp_3=>"Modified",:iSortCol_0=>0,:sSortDir_0=>"asc",:iSortingCols=>0,:bSortable_0=>true,:bSortable_1=>true,:bSortable_2=>true,:bSortable_3=>true}}
	response = conn.post do |req|
	  req.url 'http://lims.dccouncil.us/_layouts/15/uploader/AdminProxy.aspx/GetPublicAdvancedSearch'
	  req.headers['Content-Type'] = 'application/json'
	  req.body = body.to_json
	end
	return JSON.parse(response.body)['d']
end