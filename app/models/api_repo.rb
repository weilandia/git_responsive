class APIRepo
  attr_reader :name
  attr_accessor :views
  def initialize(repo, current_user)
    @name = repo[:name]
  end

  def self.service(current_user)
    GithubService.new(current_user)
  end

  def self.all(current_user)
    service(current_user).repos.map do |repo|
      APIRepo.new(repo, current_user)
    end
  end

  def self.find(current_user, name)
    repo = APIRepo.new(service(current_user).repo(name), current_user)
    repo.views = APIView.all(current_user, repo.name).compact
    repo
  end
  
  def self.generate_issues(current_user, name)
    repo = self.find(current_user, name)
    repo.views.each do |view|
      if view.class == Array
        view.first.post_issue(current_user, repo.name, view.first.path)
      else
        view.post_issue(current_user, repo.name, view.path)
      end
    end
  end
end