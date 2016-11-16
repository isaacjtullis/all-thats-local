FactoryGirl.define do
  factory :comment do
    description "Delicious and scrumptous!"
    likes_count 0

    association :user
    association :review
  end
end
