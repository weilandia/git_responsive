Rails.application.routes.draw do
  resource :users, as: :user, path: ":username", only: [:show] do
    resource :api_repos, as: :apirepo, path: ":name", only: [:index, :show]
  end

  root 'static_pages#home'
  get 'sessions/destroy', as: :signout
  get '/auth/github', as: :github_login
  get '/auth/:provider/callback', to: 'sessions#create'
end
