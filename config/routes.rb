# frozen_string_literal: true

Rails.application.routes.draw do
  resources :card_comments
  devise_for :auths

  namespace :api do
    # auth
    resources :auths, only: :show
    get '/auths_by_email', to: 'auths_by_emails#show', as: :auths_by_email

    # kanban_assignee
    get '/kanban_assignees', to: 'kanban_assignees#get_assignees'
    post '/kanban_assignees/assign', to: 'kanban_assignees#assign'
  end

  resources :accounts
  resource :profile, only: %i[show update]

  # kanban
  resources :kanbans
  patch '/kanbans/:id/sort', to: 'kanbans#sort', as: 'kanban_sort'

  # kanban column
  resources :kanban_columns

  # card
  resources :cards
  # card comment
  resources :card_comments

  root 'home#index'
end
