module GithubViews
  def view_dir(repo)
    get("/repos/#{@user.nickname}/#{repo}/contents/app/views?ref=master")
  end

  def views(view_sub_dir, repo)
    get("/repos/weilandia/#{repo}/contents/app/views/#{view_sub_dir}?ref=master")
  end

  def post_issue(repo, view)
    post("/repos/#{@user.nickname}/#{repo}/issues", issue_params(view))
  end

  def issue_params(view)
    {
      "title": "Is #{view} responsive?",
      "body": "Make sure it is!",
      # "assignee": "#{@user.nickname}",
      "labels": [
        "enhancement"
      ]
    }
  end
end
