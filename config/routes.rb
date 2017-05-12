Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'auth/registration',  to: 'users#create'
  post 'tasks/create',       to: 'tasks#create'
  put  'tasks/close/:id',    to: 'tasks#close'
  get  'tasks/list',         to: 'tasks#list'
end
