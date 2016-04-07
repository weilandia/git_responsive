class ApiReposController < ApplicationController
  def show
    @repo = APIRepo.find(current_user, repo_params[:name])
  end

  def create
    repo = APIRepo.generate_issues(current_user, repo_params[:name])
    db_repo = repo.save_to_db(current_user)
    require "pry"; binding.pry
    if db_repo.save
      flash[:info] = "#{db_repo.views.count} responsiveness reminders have been created."
      redirect_to user_path(current_user.nickname)
    else
    end
  end

  def update
    apirepo = APIRepo.refresh_issues(current_user, repo_params[:name])
    repo, update_count = Repo.find_by(repo_params).refresh_issues(apirepo)
    if repo.save
      flash[:info] = "#{update_count} responsiveness reminders have been created."
      redirect_to user_path(current_user.nickname)
    else
    end
  end

private
  def repo_params
    params.permit(:name)
  end
end
