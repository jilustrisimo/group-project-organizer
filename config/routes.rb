Rails.application.routes.draw do

  resources :projects do
    resources :tasks, except: :index
  end

  resources :project_teams, only: :create

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'projects#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
