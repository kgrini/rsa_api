FactoryGirl.define do
  factory :user do
    name 'dummy'
    nickname 'dummy_nick'
    sequence(:email, 'a') { |n| "email-#{n}@domain.com" }
    password 'password'
  end
end