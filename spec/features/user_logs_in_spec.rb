require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "user logs in" do
    VCR.use_cassette("sessions.login") do
      stub_omniauth
      visit "/"
      click_on "signin with github"
      expect(page).to have_content("logout")
      expect(page).to_not have_content("signin with github")
    end
 end
end
