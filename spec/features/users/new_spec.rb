require 'capybara/rspec'
require 'rails_helper'

describe "submitting a new user" do
    it "creates a new user" do
        visit '/users/new'
        within ("#new_user") do
            fill_in "user[first_name]", with: "Harold"
            fill_in "user[last_name]", with: "Houdini"
            fill_in "user[username]", with: "harold_houdini"
            fill_in "user[email]", with: "harold_houdini@gmail.com"
            fill_in "user[password]", with: "password"
            fill_in "user[password_confirmation]", with: "password"
        end
        click_button('new-user-form')
        expect(page).to have_content("Welcome to Traidr")
    end
end