class UsersController < ApplicationController
  def show
    @user = current_user
    @repos = current_user.repos
    @apirepos = APIRepo.all(current_user)
  end
end
