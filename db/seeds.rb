require 'faker'
real_addresses = [
  ["777 Brockton Avenue", "Abington", "MA", "2351"],
  ["30 Memorial Drive", "Avon","2322"],
  ["250 Hartford Avenue", "Bellingham","2019"],
  ["700 Oak Street", "Brockton","MA","2301"],
  ["66-4 Parkhurst Rd", "Chelmsford","MA","1824"],
  ["591 Memorial Dr", "Chicopee","MA","1020"],
  ["55 Brooksby Village Way", "Danvers","MA","1923"],
  ["137 Teaticket Hwy", "East Falmouth","MA","2536"],
  ["42 Fairhaven Commons Way", "Fairhaven","MA","2719"],
  ["374 William S Canning Blvd", "Fall River","MA","2721"],
  ["121 Worcester Rd", "Framingham","MA","1701"],
  ["677 Timpany Blvd", "Gardner","MA","1440"],
  ["337 Russell St", "Hadley","MA","1035"],
  ["295 Plymouth Street", "Halifax","MA","2338"],
  ["1775 Washington St", "Hanover","MA","2339"],
  ["280 Washington Street", "Hudson","MA","1749"],
  ["20 Soojian Dr", "Leicester","MA","1524"],
  ["11 Jungle Road", "Leominster","MA","1453"],
  ["301 Massachusetts Ave", "Lunenburg","MA","1462"],
  ["780 Lynnway", "Lynn","MA","1905"],
  ["70 Pleasant Valley Street", "Methuen","MA","1844"],
  ["830 Curran Memorial Hwy", "North Adams","MA","1247"],
  ["1470 S Washington St", "North Attleboro","MA","2760"],
  ["506 State Road", "North Dartmouth","MA","2747"],
  ["742 Main Street", "North Oxford","MA","1537"],
  ["72 Main St", "North Reading","MA","1864"],
  ["200 Otis Street", "Northborough","MA","1532"],
  ["180 North King Street", "Northhampton","MA","1060"],
  ["555 East Main St", "Orange","MA","1364"],
  ["555 Hubbard Ave-Suite 12", "Pittsfield", "MA", "1201"],
  ["300 Colony Place", "Plymouth", "MA", "2360"],
  ["301 Falls Blvd", "Quincy", "MA", "2169"],
  ["36 Paramount Drive", "Raynham", "MA", "2767"],
  ["450 Highland Ave", "Salem", "MA", "1970"],
  ["1180 Fall River Avenue", "Seekonk", "MA", "2771"],
  ["1105 Boston Road", "Springfield" ,"MA", "1119"],
  ["100 Charlton Road", "Sturbridge", "MA", "1566"],
  ["262 Swansea Mall Dr", "Swansea","MA", "2777"],
  ["333 Main Street", "Tewksbury","MA", "1876"],
  ["550 Providence Hwy", "Walpole", "MA", "2081"],
  ["352 Palmer Road", "Ware", "MA", "1082"],
  ["3005 Cranberry Hwy Rt 6 28", "Wareham" ,"MA", "2538"],
  ["250 Rt 59", "Airmont", "NY", "10901"]
]

ActiveRecord::Base.transaction do
  200.times do |i|
    user = User.new 
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = Faker::Internet.user_name
    user.birthday = Faker::Date.birthday(18,65)
    user.gender = ["Male","Female"][rand(0..1)]
    user.email = Faker::Internet.free_email
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = "password"
    user.address = real_addresses[rand(0..real_addresses.length-1)][0]
    user.secondary_address = Faker::Address.secondary_address if i%4 == 0
    user.city = real_addresses[rand(0..real_addresses.length-1)][1]
    user.state = "MA"
    user.country = "USA"
    user.is_offering = [Faker::Commerce.product_name,Faker::Job.title,Faker::Commerce.product_name]
    user.is_seeking =  [Faker::Commerce.product_name,Faker::Job.title,Faker::Commerce.product_name]
    user.save
  end
end