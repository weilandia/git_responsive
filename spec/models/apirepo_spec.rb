require 'rails_helper'

describe APIRepo do
  context ".new_repos" do
    it "returns a collection of repos" do
      VCR.use_cassette "apirepo.all" do
        current_user = User.create(provider: 'github', uid: '1', token: ENV['GITHUB_USER_TOKEN'], nickname: ENV['GITHUB_USER'])
        repos = APIRepo.new_repos(current_user)
        first_repo = repos.first
        expect(first_repo.name).to eq("1511_task_manager")
        expect(first_repo.class).to eq(APIRepo)
      end
    end
  end

  context ".find" do
    it "returns a repo with its views" do
      VCR.use_cassette "apirepo.find" do
        current_user = User.create(provider: 'github', uid: '1', token: ENV['GITHUB_USER_TOKEN'], nickname: ENV['GITHUB_USER'])
        repo = APIRepo.find(current_user, "git_responsive")
        expect(repo.views.count).to eq(4)
        expect(repo.name).to eq("git_responsive")
        expect(repo.views.flatten.first.name).to eq("application.html.erb")
      end
    end
  end

  context ".generate_issues" do
    it "returns a repo (not testing issue generation)" do
      VCR.use_cassette "apirepo.generate_issues" do
        current_user = User.create(provider: 'github', uid: '1', token: ENV['GITHUB_USER_TOKEN'], nickname: ENV['GITHUB_USER'])
        repo = APIRepo.generate_issues(current_user, "1511_task_manager")
        expect(repo.views.count).to eq(6)
        expect(repo.name).to eq("1511_task_manager")
        expect(repo.views.flatten.first.name).to eq("dashboard.erb")
      end
    end
  end

  context ".refresh_issues" do
    it "returns a repo (not testing issue generation)" do
      VCR.use_cassette "apirepo.refresh_issues" do
        current_user = User.create(provider: 'github', uid: '1', token: ENV['GITHUB_USER_TOKEN'], nickname: ENV['GITHUB_USER'])
        repo = APIRepo.generate_issues(current_user, "1511_task_manager")
        expect(repo.views.count).to eq(6)
        expect(repo.name).to eq("1511_task_manager")
        expect(repo.views.flatten.first.name).to eq("dashboard.erb")
      end
    end
  end

  context ".save_to_db" do
    it "saves repos to db" do
      VCR.use_cassette "apirepo.save_to_db" do
        current_user = User.create(provider: 'github', uid: '1', token: ENV['GITHUB_USER_TOKEN'], nickname: ENV['GITHUB_USER'])
        repo = APIRepo.generate_issues(current_user, "1511_task_manager")
        repo = repo.save_to_db(current_user)
        repo.save
        expect(repo.name).to eq("1511_task_manager")
        expect(repo.sha).to eq("8ba0f2624ca2f80fa0c80fdd7efdc6d53acbe309")
        expect(repo.name).to eq("1511_task_manager")
        expect(repo.views.count).to eq(6)
      end
    end
  end
end
