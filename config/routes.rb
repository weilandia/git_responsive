Rails.application.routes.draw do
  root 'static_pages#home'
  get '/auth/github', as: :github_login
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'sessions/destroy', as: :signout

  resource :users, as: :user, path: ":username", only: [:show] do
    resource :api_repos, as: :apirepo, path: ":name", only: [:update]
  end
  post '/:username', as: :user_apirepos, to: 'api_repos#create'
end
