FactoryGirl.define do
  factory :review do
    name "Chipotle"
    cusine "Mexican"
    review "Tasty"
    price "10"
    user_id 1

    association :user, factory: :user
    association :review, factory: :review
  end
end
