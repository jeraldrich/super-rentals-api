Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  Rails.application.routes.default_url_options[:host] = "127.0.0.1"

  # devise_for :users, only: []
  devise_for :users, skip: %i[sessions registrations], controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
   # omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Api routes.
  namespace :api do
    resources :rentals, only: %i[index show create update destroy]
  end

end
