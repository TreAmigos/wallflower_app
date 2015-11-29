FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    name Faker::Name.name
    password "password"
    confirmed_at Time.now
  end
end
