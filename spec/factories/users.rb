FactoryBot.define do
  factory :user do
    name { "SampleTest" }
    sequence(:email) { |n| "sample#{n}@example.com" }
    password { "sampletestpassword" }
    password_confirmation { "sampletestpassword" }
  end
end
