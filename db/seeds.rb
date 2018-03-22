require 'faker'

ActiveRecord::Base.transaction do
  500.times do |i|
    user = User.new 
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name
    user.username = Faker::Internet.user_name
    user.birthday = Faker::Date.birthday(18,65)
    user.gender = ["Male","Female"][rand(0..1)]
    user.email = Faker::Internet.free_email
    user.phone_number = Faker::PhoneNumber.phone_number
    user.password = "password"
    user.address = Faker::Address.street_address
    user.secondary_address = Faker::Address.secondary_address if i%4 == 0
    user.city = "Kuala Lumpur"
    user.state = "Kuala Lumpur"
    user.country = "Malaysia"
    user.is_offering = [Faker::Commerce.product_name,Faker::Job.title,Faker::Commerce.product_name]
    user.is_seeking =  [Faker::Commerce.product_name,Faker::Job.title,Faker::Commerce.product_name]
    user.save
  end
end