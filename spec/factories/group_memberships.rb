FactoryGirl.define do
  factory :group_membership do
    user_id Faker::Number.between(1, 10)
    group_id Faker::Number.between(1, 10)
  end
end