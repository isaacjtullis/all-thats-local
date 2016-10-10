FactoryGirl.define do
  factory :favorite do
    vote 'upvote'
    association :user
    association :comment

  end
end
