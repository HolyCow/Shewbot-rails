Shewbot::Application.routes.draw do
  devise_for :users, :skip => [:registrations] 
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :questions

  get "rake/routes"

  root to: 'static_pages#home'

  match '/login', to: 'static_pages#login'

  match '/auth/twitter/callback', to: 'sessions#create'
  match '/auth/failure', to: 'sessions#failure'
  match '/sessions/visitor_count', to: 'sessions#visitor_count'

  match '/titles/create', to: 'titles#create'
  match '/titles', to: 'titles#index'
  match '/title/:id/upvote', to: 'titles#upvote'

  match '/links/create', to: 'links#create'
  match '/links', to: 'links#index'

  match '/questions/create', to: 'questions#create'
  match '/questions', to: 'questions#index'

  match '/shows/current', to: 'shows#current', via: :get, :defaults => { :format => 'json' }

  resources :irc_users, only: :show

  resources :shows, only: [:index, :show]

  namespace :admin do
    resources :apis
    resources :users
    resources :votes
    resources :titles
    resources :shows
    resources :irc_users
    resources :visitors, only: [:index]
  end

end
