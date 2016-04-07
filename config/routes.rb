Rails.application.routes.draw do
  root 'static_pages#home'
  get '/auth/github', as: :github_login
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'sessions/destroy', as: :signout

  resource :users, as: :user, path: ":username", only: [:show] do
    resource :api_repos, as: :apirepo, path: ":name", only: [:index, :show, :create, :update]
  end
end
