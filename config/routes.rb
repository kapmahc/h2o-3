require 'sidekiq/web'

Rails.application.routes.draw do

  namespace :admin do
    get 'site/info'
    post 'site/info'
    get 'site/status'
  end

  resources :leave_words, except: [:edit, :update, :show]

  # seo
  get '/robots' => 'home#robots', constraints: { format: 'txt' }

  # home
  post '/search' => 'home#search'
  get '/dashboard' => 'home#dashboard'

  # third
  devise_for :users

  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/jobs'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
