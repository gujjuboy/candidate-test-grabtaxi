require 'geokit'

class AssignController < ApplicationController
  def create
  	@booking_id = params['booking_id']

  	if(@booking_id == nil || @booking_id == 0) 
		output = {'status' => 'false', 'msg' => 'Input not valid!'}.to_json
		render :json => output
		return
	else
	  	@location = Geokit::Geocoders::GoogleGeocoder.geocode('182 Le Dai Hanh, HCM City, VN')
	  	@driver = Drivers.closest(:origin=>@location).first()

	  	if(@driver == nil)
	  		output = {'status' => 'false', 'msg' => "No driver at this time!"}.to_json
	  	else
	  		#Save assign record
	  		@assign = Assigns.new(params[:assign])
		    @assign.booking_id = @booking_id
		    @assign.driver_id = @driver.id
			@assign.save

			#Send background worker
			SmsJob.perform_async(@driver.name)
		    puts redis.lrange("sms",-1,-1).reverse

	  		output = {'status' => 'true', 'data' => @driver}.to_json
	  	end

	  	render :json => output
		return
	end

  end

  private
  def redis
    @redis ||= Redis.new
  end
end
