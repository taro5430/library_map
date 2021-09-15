Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  get 'pages/introduction'
  get 'pages/profile'
  devise_for :users
  get '/libraries/search', to: 'libraries#search'
  resources :libraries
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
