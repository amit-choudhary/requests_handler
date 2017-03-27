FactoryGirl.define do
  factory :support_agent do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    type 'SupportAgent'
  end
end
