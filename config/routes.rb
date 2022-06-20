Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Api routes.
  namespace :api do
    resource :rentals, only: %i[index show create update destroy]
  end

end
