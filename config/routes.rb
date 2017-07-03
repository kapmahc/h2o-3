require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/jobs'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
