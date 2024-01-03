# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :auths

  namespace :api do
    resources :auths, only: :show
    get '/auths_by_email', to: 'auths_by_emails#show', as: :auths_by_email
  end

  resources :accounts, controller: 'api/accounts'
  resource :profile, controller: 'api/profile', only: [:show, :update, :destroy]
  resources :kanbans, controller: 'api/kanbans'

  root 'home#index'
end
