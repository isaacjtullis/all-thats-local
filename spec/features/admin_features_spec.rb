require 'rails_helper'

feature 'sign in', %Q{
  As the admin
  I want to sign in
  And supervise content
} do
  describe '#admin?' do
    it 'determines if user is admin' do
      admin = User.create(
      first_name: "John",
      last_name: "Smith",
      email: 'johnsmith@smith.com',
      password: 'password',
      password_confirmation: 'password',
      role: 'admin')

      expect(admin.admin?).to eql(true)
    end
  end

  scenario 'Admin Signs in' do
    admin = User.create(
    first_name: "John",
    last_name: "Smith",
    email: 'johnsmith@smith.com',
    password: 'password',
    password_confirmation: 'password',
    role: 'admin')

    user = FactoryGirl.create(:user)
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

    visit root_path
    click_link 'Sign In'

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_content("Welcome Back!")
    expect(page).to have_button("ADMIN DELETE")
  end
end
