class PassengerController < ApplicationController
  def create
  	@phone = params[:phone]

  	if(@phone == nil || @phone == 0) 
			output = {'status' => 'false', 'msg' => 'Input not valid!'}.to_json
			render :json => output
			return
		end

		if @passenger = Passengers.where(:phone => @phone).first

			#Return data for the purposes of this test with password:
			output = {'status' => 'false', 'msg' => 'Passenger exists!', 'data' => @passenger}.to_json
			render :json => output
			return
		else
		    @passenger = Passengers.new(params[:passenger])
		    @passenger.phone = @phone
		    @passenger.password = (0...4).map { (65 + rand(26)).chr }.join
			if @passenger.save
				#If app is production, we need send password to phone number by SMS and return this:
				#output = {'status' => 'true', 'msg' => "Create passenger success!"}.to_json

				#For the purposes of this test should I return password here:
				output = {'status' => 'true', 'data' => @passenger}.to_json
			else
			  output = {'status' => 'false', 'msg' => @passenger.errors}.to_json
			end

			render :json => output

		end
		
  end
end
