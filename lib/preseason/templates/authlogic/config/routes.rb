
  # authentication routes
  resource :user_sessions
  resources :users

  get '/signup', to: 'users#new'
  get '/login', to: 'user_sessions#new'
  delete '/logout', to: 'user_sessions#destroy'
  get :forgot_password,           to: 'user_sessions#forgot_password'
  post :forgot_password,          to: 'user_sessions#send_reset_password_link'
  get '/reset_password/:token',   to: 'user_sessions#acquire_password'
  post '/reset_password/:token',  to: 'user_sessions#reset_password'
