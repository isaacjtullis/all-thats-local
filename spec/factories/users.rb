FactoryGirl.define do
  factory :user do
    email { generate(:email) }
    first_name 'John'
    last_name 'Smith'
    password 'password'
    password_confirmation 'password'
  end
  sequence :email do |n|
    "test#{n}@example.com"
  end
end
