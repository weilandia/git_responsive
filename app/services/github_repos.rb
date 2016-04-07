module GithubRepos
  def repos
    get("/users/#{@user.nickname}/repos")
  end

  def repo(name)
    get("repos/#{@user.nickname}/#{name}")
  end

  def issues(repo)
    get("/repos/#{@user.nickname}/#{repo}/issues")
  end
end
