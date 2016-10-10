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
    find('.adventure').click

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
    find('.adventure').click

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
    find('.adventure').click

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
    find('.adventure').click

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
      find('.adventure').click

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
    #ActionMailer::Base.deliveries = []
    ActionMailer::Base.deliveries.clear
    include EmailSpec::Helpers
    include EmailSpec::Matchers
    include Rails.application.routes.url_helpers
    user = FactoryGirl.create(:user)
    user_two = FactoryGirl.create(:user)

    visit root_path
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    find('.adventure').click

    fill_in 'Name', with: "Garbanzo Delights"
    select('French', :from => 'Cusine')
    select('10', :from => 'Price')
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    visit root_path
    click_link 'Sign Out'

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Garbanzo Delights'

    fill_in 'Description', with: 'Garbanzo Delights is a wonderful restaurant'
    click_button 'Create Comment'
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject('New Review for Garbanzo Delights')
    expect(last_email).to deliver_to(user.email)
  end

  feature 'User upvotes a comment' do
    before do
      user = FactoryGirl.create(:user)

      visit root_path
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'

      visit root_path
      find('.adventure').click

      fill_in 'Name', with: "Garbanzo Delights"
      select('French', :from => 'Cusine')
      select('10', :from => 'Price')
      fill_in 'Review', with: 'Delicious!'
      click_button 'Post'

      fill_in 'Description', with: 'Garbanzo Delights is a wonderful restaurant'
      click_button 'Create Comment'
    end

    feature 'No votes exist' do
      scenario 'User upvotes' do

        expect(page).to have_selector('.vote-count', text: '0')
        click_button 'UPVOTE'

        expect(page).to have_selector('.vote-count', text: '1')
      end
      scenario 'User downvotes' do
        expect(page).to have_selector('.vote-count', text: '0')
        click_button 'DOWNVOTE'

        expect(page).to have_selector('.vote-count', text: '-1')
      end
    end

    feature 'User already has voted' do

      scenario 'User upvoted, cannot upvote again' do
        expect(page).to have_selector('.vote-count', text: '0')
        click_button 'UPVOTE'

        expect(page).to have_selector('.vote-count', text: '1')
        click_button 'UPVOTE'
        expect(page).to have_selector('.vote-count', text: '1')
        expect(page).to have_content('You have already upvoted this!')
      end

      scenario 'User downvoted, cannot downvote again' do
        expect(page).to have_selector('.vote-count', text: '0')
        click_button 'DOWNVOTE'

        expect(page).to have_selector('.vote-count', text: '-1')
        click_button 'DOWNVOTE'
        expect(page).to have_content('You have already downvoted this!')
      end

      scenario 'User upvoted, they can downvote' do
        expect(page).to have_selector('.vote-count', text: '0')
        click_button 'UPVOTE'

        expect(page).to have_selector('.vote-count', text: '1')
        click_button 'DOWNVOTE'

        expect(page).to have_content('You have successfully downvoted!')
        expect(page).to have_selector('.vote-count', text: '-1')
      end

      scenario 'User downvoted, they can upvote' do
        expect(page).to have_selector('.vote-count', text: '0')
        click_button 'DOWNVOTE'

        expect(page).to have_selector('.vote-count', text: '-1')
        click_button 'UPVOTE'

        expect(page).to have_content('Thank you for upvoting!')
        expect(page).to have_selector('.vote-count', text: '1')
      end
    end
    feature 'Votes work with multiple existing votes' do
      #GOALS FOR REFACTORING
      #1. Eliminate manually adding the likes count
      #2. Put Upvote and Downvote in their own controller
      before do
        user = FactoryGirl.create(:user)
        @review = FactoryGirl.create(:review)
        @review.user = user
        @review.save
        comment = FactoryGirl.create(:comment)
        @review.comments << comment
        20.times do
          random_user = FactoryGirl.create(:user)
          favorite = FactoryGirl.create(:favorite)
          favorite.user = random_user
          favorite.vote = "upvote"
          favorite.comment = comment
          favorite.save
          comment.favorites << favorite
          comment.likes_count += 1
          comment.save
        end
      end
      scenario 'User upvotes' do
        visit review_path(@review.id)
        expect(page).to have_selector('.vote-count', text: '20')
        click_button 'UPVOTE'

        expect(page).to have_selector('.vote-count', text: '21')
      end

      scenario 'User downvotes' do
        visit review_path(@review.id)
        expect(page).to have_selector('.vote-count', text: '20')
        click_button 'DOWNVOTE'

        expect(page).to have_selector('.vote-count', text: '19')
      end
      scenario 'User downvotes after upvoting' do
        visit review_path(@review.id)
        expect(page).to have_selector('.vote-count', text: '20')
        click_button 'UPVOTE'

        expect(page).to have_selector('.vote-count', text: '21')
        click_button 'DOWNVOTE'

        expect(page).to have_selector('.vote-count', text: '19')
      end
      scenario 'User upvotes after downvoting' do
        visit review_path(@review.id)
        expect(page).to have_selector('.vote-count', text: '20')
        click_button 'DOWNVOTE'

        expect(page).to have_selector('.vote-count', text: '19')
        click_button 'UPVOTE'

        expect(page).to have_selector('.vote-count', text: '21')
      end
    end
  end
end
