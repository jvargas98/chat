require 'rails_helper'

feature 'User management' do
  scenario "Adds a new user" do
    user = create(:user)

    visit root_path
    expect{
      click_link 'Sign up'
      fill_in 'user_email', with: 'ale@gmail.com'
      fill_in 'user_user_name', with: 'elale'
      fill_in 'user_name', with: 'Alejandro'
      fill_in 'user_password', with: 'pass12345'
      fill_in 'user_password_confirmation', with: 'pass12345'
      click_button 'Sign up'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
  end

  scenario "Already existent user can Log in" do
    user = create(:user)

    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(current_path).to eq root_path
  end
end
