Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  

  resources :conversations, shallow: true do
    resources :messages
  end

  root to: 'conversations#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
