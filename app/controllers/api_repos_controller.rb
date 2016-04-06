class ApiReposController < ApplicationController
  def show
    @repo = APIRepo.find(current_user, repo_params[:name])
  end

  def create
    APIRepo.generate_issues(current_user, repo_params[:name])
  end

private
  def repo_params
    params.permit(:name)
  end
end
