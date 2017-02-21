
  # authentication routes
  get :login,                     to: 'user_sessions#new'
  post :login,                    to: 'user_sessions#create'
  delete :logout,                 to: 'user_sessions#destroy'
  get :forgot_password,           to: 'user_sessions#forgot_password'
  post :forgot_password,          to: 'user_sessions#send_reset_password_link'
  get '/reset_password/:token',   to: 'user_sessions#acquire_password'
  post '/reset_password/:token',  to: 'user_sessions#reset_password'
  get :register,                  to: 'users#new'
  post :register,                 to: 'users#create'
