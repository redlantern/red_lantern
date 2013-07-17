# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ticket do
    sender { Faker::Internet.email }
    subject "Phone freeze"
    body    "The phone freezes after a long phone call"
    status  "New"
  end
end
