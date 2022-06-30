# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root to: 'welcome#index'

  namespace :terra do
    root to: 'welcome#index'
    resources :questions do
      resources :answers, shallow: true
    end

    resources :users
  end
end
