require 'rails_helper'

RSpec.feature "user generates issues for repo" do
  scenario "user logs in" do
    VCR.use_cassette("sessions.login") do
      stub_omniauth
      visit "/"
      click_on "signin with github"

    end
 end
end
