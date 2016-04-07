class UsersController < ApplicationController
  def show
    @apirepos = APIRepo.new_repos(current_user)
    @repo = Repo.new
  end
end
