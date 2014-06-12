class Drivers < ActiveRecord::Base
	acts_as_mappable :lat_column_name => :lat,
                   :lng_column_name => :long
end
