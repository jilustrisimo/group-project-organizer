Rails.application.routes.draw do

  resources :projects do
    resources :tasks, except: %i[index show]
  end

  resources :project_teams, only: %i[create destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/users/:user_id/tasks', to: 'tasks#index'
  post '/users/:user_id/tasks/:task_id/edit', to: 'tasks#assign'

  root 'projects#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
