Rails.application.routes.draw do
  resources :sessions, only: [:create, :destroy]
  resources :customers, only: [:index,:show,:create,:update,:destroy]
end
