Rails.application.routes.draw do
  root :to => 'tops#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  get "/users/favorites/:id" => "users#favorites"
  get "/users/profile/:id" => "users#profile"
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :tops
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
