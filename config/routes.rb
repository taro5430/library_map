Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  devise_for :users
  resources :libraries
  get '/libraries_display' ,to: 'libraries#display'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
