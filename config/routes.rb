Rails.application.routes.draw do
  root 'users#index'
  
  resources :users, only: [:index, :show, :edit, :update] do
    collection do
      get 'search'
    end
    member do
      get 'album_details/:album_id', to: 'users#album_details', as: 'album_details'
    end
  end
end
