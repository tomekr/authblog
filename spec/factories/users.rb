FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "heluhelu1" }
  end
end
