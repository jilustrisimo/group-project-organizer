Rails.application.routes.draw do

  resources :projects do
    resources :tasks, except: :index
  end

  resources :project_teams, only: %i[create destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  post '/users/:user_id/tasks/:task_id/edit', to: 'tasks#assign'
  get '/users/:user_id/tasks', to: 'tasks#display'

  root 'projects#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
