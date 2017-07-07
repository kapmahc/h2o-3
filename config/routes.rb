require 'sidekiq/web'

Rails.application.routes.draw do

  # survey
  namespace :survey do
    resources :forms, except: [:show] do
      resources :fields, except: [:show]
      resources :records, only: [:new, :create, :destroy, :index]
    end
  end

  # forum
  namespace :forum do
    resources :tags do
      collection do
        get 'latest'
      end
    end

    resources :articles do
      collection do
        get 'latest'
      end
    end

    resources :comments, except: [:show] do
      collection do
        get 'latest'
      end
    end

  end

  # admin
  namespace :admin do
    %w(info languages nav donate).each do |act|
      get "site/#{act}"
      post "site/#{act}"
    end

    get 'site/status'

    resources :users, only: [:index]

    resources :cards, except: [:show]
  end

  post '/votes' => 'votes#index'

  resources :attachments, only: [:index, :new, :create, :destroy]

  # leave words
  resources :leave_words, except: [:edit, :update, :show]

  # seo
  get '/robots' => 'home#robots', constraints: {format: 'txt'}
  get '/rss' => 'home#rss', constraints: {format: 'atom'}

  # home
  post '/search' => 'home#search'
  %w(dashboard donate).each {|act|get "/#{act}" => "home##{act}"}


  # third
  devise_for :users

  authenticate :user, lambda {|u| u.is_admin?} do
    mount Sidekiq::Web => '/jobs'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
