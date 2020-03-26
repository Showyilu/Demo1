# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  namespace :v1 do
    get "jwt/auth" => "jwt#auth"
  end
end
