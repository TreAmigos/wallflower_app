FactoryGirl.define do
  factory :current_group do
    user_id Faker::Number.between(1, 10)
    group_id Faker::Number.between(1, 10)
  end
end