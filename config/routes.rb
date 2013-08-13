EmberTwitter::Application.routes.draw do
  get 'auth/twitter/callback', to: 'sessions#create'
  resource  :session
  resources :timelines, only: :show
  resource  :user, only: :show

  get 'home' => 'home#index'

  root  to:   'home#index'
end
