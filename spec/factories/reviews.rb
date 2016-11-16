FactoryGirl.define do
  factory :review do
    name "Chipotle"
    cusine "American"
    review "Tasty"
    price "10"
    user_id 1

    association :user
  end
end
