class UsersController < ApplicationController
  def show
    @user = current_user
    @repos = APIRepo.all(current_user)
  end
end
