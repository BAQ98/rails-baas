# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :auths

  namespace :api do
    resources :auths, only: :show
    get '/auths_by_email', to: 'auths_by_emails#show', as: :auths_by_email
  end

  resources :accounts
  resource :profile, only: [:show, :update]
  resources :kanbans
  resources :kanban_columns
  resources :cards

  root 'home#index'
end
