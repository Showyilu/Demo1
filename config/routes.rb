# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  namespace :v1 do
    post "jwt/auth" => "jwt#auth"

    resources :tasks, only: [:index, :create] do
      member do
        put :complete
        put :undo_complete
      end
    end
  end
end
