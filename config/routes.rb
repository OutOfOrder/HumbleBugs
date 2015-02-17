HumbleBugs::Application.routes.draw do
  resources :bundles do
    resources :games
  end

  resources :games do
    resources :issues
    resources :releases, :only => [:new, :create, :index]
    resources :ports
  end

  resources :releases, :except => [:new, :create, :index] do
    get :download, :on => :member
    resources :test_results, :only => [:index, :new, :create]
  end

  resources :test_results, :except => [:new, :create, :index]

  resources :issues, :only => [:index, :new, :create] do
    resources :comments, :except => [:index]
  end

  resources :developers

  resources :users do
    resources :systems

    get :nda, :on => :member
    post :nda, :on => :member, :action => 'sign_nda'
    post :confirm, :on => :member
  end

  resources :predefined_tags do
    collection do
      get ':context', :action => 'complete', :as => :complete, :constraints => {
          context: /(new[a-z]+|(?!new)[a-z]+)/
      }
    end
  end

  get '/feedback' => 'feedback#new', :as => :feedback
  post '/feedback' => 'feedback#create', :as => :feedback

  get '/login' => 'sessions#new', :as => :login
  if Rails.env.test? || Rails.env.development?
    post '/secret_login' => 'sessions#secret_login', :as => :secret_login
  end
  post '/login' => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  get '/forgot_password' => 'password_reset#new', :as => :forgot_password
  post '/forgot_password' => 'password_reset#create', :as => :forgot_password
  get '/forgot_password/:id' => 'password_reset#edit', :as => :password_reset
  put '/forgot_password/:id' => 'password_reset#update', :as => :password_reset

  get '/confirm_account/:id' => 'confirm_account#confirm', :as => :confirm_account

  get 'signup' => 'users#new', :as => :signup

  resource :dashboard, controller: 'dashboard', only: [:show, :update]

  root :to => redirect { |p,req|
    req.flash.keep
    '/dashboard'
  }
end
