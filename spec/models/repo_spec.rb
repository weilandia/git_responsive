require 'rails_helper'

RSpec.describe Repo, type: :model do
  scenario "it genereates sha" do
    current_user = User.create(provider: 'github', uid: '1', token: ENV['GITHUB_USER_TOKEN'], nickname: ENV['GITHUB_USER'])
    repo = Repo.new(name:"test", user_id: current_user.id)
    repo.save
    expect(repo.sha).to eq("ef56b88c6098f56aeefb79c1e34d6665523ea2c3")
  end

  context ".refresh_issues" do
    it "refresh_issues" do
      VCR.use_cassette "repo.refresh_issues" do
        current_user = User.create(provider: 'github', uid: '1', token: ENV['GITHUB_USER_TOKEN'], nickname: ENV['GITHUB_USER'])
        repo = APIRepo.generate_issues(current_user, "authentication-example")
        db_repo = repo.save_to_db(current_user)
        refresh = db_repo.refresh_issues(repo, current_user)
        expect(refresh[1]).to eq(4)
      end
    end
  end
end
