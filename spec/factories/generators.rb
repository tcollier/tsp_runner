FactoryGirl.define do
  sequence :location_name do |n|
    [Faker::Address.city, n].join('-')
  end
end