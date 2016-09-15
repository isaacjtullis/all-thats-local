require 'rails_helper'

feature 'review', %Q{
  As an unathenticated user
  I want to review a city
} do
  scenario 'user can leave a review' do
    user = FactoryGirl.create(:user)
  end
end
