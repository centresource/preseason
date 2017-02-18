
  # authentication routes
  get :login,                     to: 'user_session#new'
  post :login,                    to: 'user_session#create'
  delete :logout,                 to: 'user_session#destroy'
  get :forgot_password,           to: 'user_session#forgot_password'
  post :forgot_password,          to: 'user_session#send_reset_password_link'
  get '/reset_password/:token',   to: 'user_session#acquire_password'
  post '/reset_password/:token',  to: 'user_session#reset_password'
  get :register,                  to: 'users#new'
  post :register,                 to: 'users#create'
