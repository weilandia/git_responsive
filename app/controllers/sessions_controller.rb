class SessionsController < ApplicationController
  def create
    user_info = request.env["omniauth.auth"]
    if user = User.from_omniauth(user_info)
      session[:user_id] = user.id
      session[:user_info] = user_info
    end
    redirect_to user_path(current_user.nickname)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
