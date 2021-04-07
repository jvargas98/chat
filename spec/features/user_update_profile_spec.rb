require 'rails_helper'

feature 'User update profile' do
  let(:user) { create(:user) }

  before(:each) do
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
  end

  context "Successfully" do
    scenario "When changes some user fields" do
      visit edit_user_registration_path
      fill_in 'user_email', with: Faker::Internet.unique.safe_email 
      password = Faker::Internet.password 
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      fill_in 'user_current_password', with: user.password
      click_button 'Update'
      expect(current_path).to eq root_path
    end

    scenario "When uploads a photo" do
      visit edit_user_registration_path
      page.find('#user_image').click
      page.attach_file('user[image]', Rails.root + 'spec/fixtures/test.png')
      fill_in 'user_current_password', with: user.password
      click_button 'Update'
      expect(current_path).to eq root_path
    end

    scenario "When deletes his photo", js: true do
      visit edit_user_registration_path
      page.attach_file('user[image]', Rails.root + 'spec/fixtures/test.png')
      fill_in 'user_current_password', with: user.password
      click_button 'Update'
      visit edit_user_registration_path
      page.find('.btn-danger').click
      page.accept_alert
      fill_in 'user_current_password', with: user.password
      click_button 'Update'
      expect(current_path).to eq root_path
    end
  end
end
