module GithubRepos
  def repos
    get("/users/#{@user.nickname}/repos")
  end

  def repo(name)
    get("repos/#{@user.nickname}/#{name}")
  end
end
