require 'rails_helper'

feature 'review', %Q{
  As an unathenticated user
  I want to comment on a restaurant review
} do
  scenario 'user cannot leave an empty comment' do
    user = FactoryGirl.create(:user)

    visit root_path
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    click_button 'Create Comment'

    expect(page).to have_content("Comment was not saved")
  end

  scenario 'user views a list of comments' do
    user = FactoryGirl.create(:user)

    visit root_path
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    fill_in 'Description', with: 'Garbanzo Delights is a wonderful restaurant'
    click_button 'Create Comment'

    expect(page).to have_content("Garbanzo Delights is a wonderful restaurant")
  end
  scenario 'user writes a comment and edits their comment' do
    user = FactoryGirl.create(:user)

    visit root_path
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    fill_in 'Description', with: 'Garbanzo Delights is a wonderful restaurant'
    click_button 'Create Comment'

    click_link 'Edit Comment'
    fill_in 'Description', with: 'Garbanzo Delights is disgusting'
    click_button 'Update Comment'

    expect(page).to have_content('Garbanzo Delights is disgusting')
  end
  scenario 'user deletes their comment' do
    user = FactoryGirl.create(:user)

    visit root_path
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    fill_in 'Description', with: 'Garbanzo Delights is a wonderful restaurant'
    click_button 'Create Comment'

    click_link 'Delete Comment'

    expect(page).to have_content ('Comment was deleted!')
    expect(page).to_not have_content('Garbanzo Delights is disgusting')
  end

  scenario 'User cannot delete a comment if they did not make it' do
      user = FactoryGirl.create(:user)
      user1 = FactoryGirl.create(:user)

      visit root_path
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'

      visit root_path
      click_link 'Share Your Own Adventure'

      fill_in 'Name', with: "Garbanzo Delights"
      select('French', :from => 'Cusine')
      select('10', :from => 'Price')
      fill_in 'Review', with: 'Delicious!'
      click_button 'Post'

      fill_in 'Description', with: 'Garbanzo Delights is a wonderful restaurant'
      click_button 'Create Comment'

      visit root_path
      click_link 'Sign Out'

      visit new_user_session_path

      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Sign In'
      visit root_path

      click_link 'Garbanzo Delights'

      click_link 'Delete Comment'

      expect(page).to have_content ('You cannot delete a comment you did not make!')
      expect(page).to have_content('Garbanzo Delights is a wonderful restaurant')
  end

  scenario "sends an email confirmation" do
    ActionMailer::Base.deliveries = []
    ActionMailer::Base.deliveries.clear
    include EmailSpec::Helpers
    include EmailSpec::Matchers
    include Rails.application.routes.url_helpers
    user = FactoryGirl.create(:user)

    visit root_path
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Share Your Own Adventure'

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    fill_in 'Description', with: 'Garbanzo Delights is a wonderful restaurant'
    click_button 'Create Comment'

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject('New Review for Garbanzo Delights')
    expect(last_email).to deliver_to(user.email)
  end
end
