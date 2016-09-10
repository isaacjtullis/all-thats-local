feature 'creates review', %Q{
  As an unathenticated user
  I want to create a review
} do

  scenario 'visitor cannot make a review until they are signed-in' do
    visit root_path
    click_link 'Add Review'

    expect(page).to have_content('You must be logged in to make changes!')
  end

  scenario 'User creates new review for restaurant' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Add Review'

    fill_in 'Name', with: "Garbanzo Delights"
    fill_in 'Cusine', with: "French"
    fill_in 'Price', with: "$$$"
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'


    expect(page).to have_content("Garbanzo Delights")
    expect(page).to have_content("French")
    expect(page).to have_content("$$$")
    expect(page).to have_content("Delicious!")
  end

  scenario 'User can go back to home screen' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path
    click_link 'Add Review'

    fill_in 'Name', with: "Garbanzo Delights"
    fill_in 'Cusine', with: "French"
    fill_in 'Price', with: "$$$"
    fill_in 'Review', with: 'Delicious!'
    click_button 'Post'

    click_link 'Home'

    expect(page).to have_content("Garbanzo Delights")
  end
end
