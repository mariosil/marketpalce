Rails.application.routes.draw do
  # https://www.rubydoc.info/github/plataformatec/devise/master/ActionDispatch/Routing/Mapper#devise_for-instance_method
  # skip: tell which controller you want to skip routes from being created
  devise_for :users, skip: :all

  namespace :api do
    namespace :v1 do
      devise_scope :users do
        post 'sessions/create'
        delete 'sessions/destroy'
      end
      get 'people/whoami'
    end
  end
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
