FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    type { ['Admin', 'Customer', 'SupportAgent'].sample }
  end
end
