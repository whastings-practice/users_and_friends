Socialthing::Application.routes.draw do
  resources :users do
    collection do
      get 'reset-password' => 'users#reset_password', :as => 'password_reset'
      post 'reset-password' => 'users#send_reset_email'
      get 'new-password' => 'users#new_password', :as => 'new_password'
    end
  end

  resource :session, only: [:new, :create, :destroy]

  resources :friend_circles
end
