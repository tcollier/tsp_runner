FactoryGirl.define do
  factory :location, class: TspRunner::Location do
    name { generate(:location_name) }
    lat { Float(Faker::Address.latitude) }
    lon { Float(Faker::Address.longitude) }

    initialize_with { new(name, lat, lon) }
  end
end