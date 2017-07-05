require 'sidekiq/web'

Rails.application.routes.draw do

  post '/votes' => 'votes#index'

  # forum
  namespace :forum do
    resources :tags

    resources :articles do
      collection do
        get 'my'
      end
    end

    resources :comments, except: [:show] do
      collection do
        get 'my'
      end
    end

  end

  # admin
  namespace :admin do
    %w(info languages nav).each do |act|
      get "site/#{act}"
      post "site/#{act}"
    end

    get 'site/status'

    resources :cards
  end

  # leave words
  resources :leave_words, except: [:edit, :update, :show]

  # seo
  get '/robots' => 'home#robots', constraints: { format: 'txt' }
  get '/rss' => 'home#rss', constraints: { format: 'atom' }

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
