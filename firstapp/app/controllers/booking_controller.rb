require 'rest_client'
require 'json'
class BookingController < ApplicationController
	def index
	end

	def create
		@phone = params[:phone]
		@password = params[:password]

	    output = {'status' => 'false'}

		if Passengers.exists?(:phone => @phone, :password => @password)
		  	@booking = Bookings.new(params[:booking])
		    @booking.phone = @phone

			if @booking.save
				@booking_id = @booking.id

				output = assignDriver(:booking_id => @booking_id)

			else
				output["msg"] = @passenger.errors
			end
			
			render :json => output.to_json
		else
			output["msg"] = 'Passenger not authenticated!'
		  	render :json => output.to_json
		end
	end

	private
	def assignDriver(booking_id)

		output = {'status' => 'false'}

		RestClient.get(APP_CONFIG['second_app_url']+"/assign/create", {:params => {:booking_id => booking_id}}){ |res, request, result, &block|
			case res.code
			when 200
				data = JSON.parse(res)
				if data["status"] == "true"
					@driver = data["data"]

					output["status"] = "true"
					output["data"] = @driver
				else
					output["msg"] = data["msg"]
				end 
			else
				output["msg"] = "Call Api Fail!"
			end
		}
		return output
		
	end
end
