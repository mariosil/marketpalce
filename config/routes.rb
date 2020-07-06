Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'sessions/create'
      get 'sessions/destroy'
    end
  end
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
