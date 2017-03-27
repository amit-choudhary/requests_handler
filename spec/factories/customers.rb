FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    type 'Customer'
  end
end
