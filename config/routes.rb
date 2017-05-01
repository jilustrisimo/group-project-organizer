Rails.application.routes.draw do

  resources :projects do
    resources :tasks, except: %i[index show]
  end

  resources :project_teams, only: %i[create destroy]
  resources :search, only: :index

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'projects#index'

  # display, add/remove routes for current_user.tasks

  get '/users/:user_id/tasks', to: 'tasks#index'
  post '/users/:user_id/tasks/:task_id/edit', to: 'tasks#assign'
  delete '/users/:user_id/tasks/:task_id', to: 'tasks#unassign'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
