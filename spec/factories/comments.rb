FactoryGirl.define do
  factory :comment do
    description "Delicious and scrumptous!"

    association :user, factory: :user
    association :review, factory: :review
  end
end
