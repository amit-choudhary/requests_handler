FactoryGirl.define do
  factory :request do
    customer
    support_agent
    subject 'test subject'
    content 'test content'
  end
end
