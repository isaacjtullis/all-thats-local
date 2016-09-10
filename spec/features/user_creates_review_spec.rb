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
  visit root_path
  click_link 'Add Review'

  fill_in 'Name', with: 'Garbanzo Delights'
  select 'French', from: 'Cusine'
  select 5, from: 'Rating'
  select "$15-20", from: 'Price'
  fill_in 'Review', with: 'Delicious!'
  click_button 'Post'

  expect(page).to have_content('Garbanzo Delights')
  expect(page).to have_content('Sign Out')
#I need a simple_form
#I need to have select down options
#I need a section to add reviews
#Can I add a photo?
  end
scenario 'User has to sign-in before they can make a review'
end
=begin
reviews
  name
  cusine
  rating
  review
  user_id
  *Authenticate if it is admin or not

users

comments
  *Need to be signed in
  user_id ?
  review_id
=end
