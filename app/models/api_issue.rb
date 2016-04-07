class APIIssue
  attr_reader :title
  def initialize(issue, current_user)
    @title = issue[:title]
  end

  def self.service(current_user)
    GithubService.new(current_user)
  end


  def self.reject?(current_user, repo, view)
    issues = service(current_user).issues(repo)
    issues.each do |issue|
      if issues[0][:title].split[1] == view.path
        return false
      end
    end
  end
end
