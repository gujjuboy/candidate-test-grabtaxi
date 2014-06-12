# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

hcm_lat = 660172
hcm_long = 762622

Drivers.delete_all

x = 10
x.times do |x|
    latitude = rand(hcm_lat...hcm_long)
	longitude = rand(hcm_lat...hcm_long)
	Drivers.create(name: 'Emanue'+ x.to_s, phone: rand(900000000...999999999), lat:("10."+latitude.to_s).to_f, long:("106."+longitude.to_s).to_f)

end

