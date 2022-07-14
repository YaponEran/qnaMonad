# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root to: 'welcome#index'

  namespace :terra do

    concern :votable do
      member do
        patch :vote_up
        patch :vote_down
      end
    end

    concern :commentable do
      resources :comments, only: [:create, :update, :destroy]
    end

    root to: 'welcome#index'
    resources :questions, concerns: [:votable, :commentable] do
      resources :answers, concerns: [:votable, :commentable], shallow: true do
        patch :choose_best, on: :member
      end
    end

    resources :users
  end
end
