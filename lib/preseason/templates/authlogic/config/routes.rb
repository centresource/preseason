
  # authentication routes
  get :login,                     to: 'user_session#new',                      as: :login
  post :login,                    to: 'user_session#create',                   as: :login
  delete :logout,                 to: 'user_session#destroy',                  as: :logout
  get :forgot_password,           to: 'user_session#forgot_password',          as: :forgot_password
  post :forgot_password,          to: 'user_session#send_reset_password_link', as: :forgot_password
  get '/reset_password/:token',   to: 'user_session#acquire_password',         as: :reset_password
  post '/reset_password/:token',  to: 'user_session#reset_password',           as: :reset_password
  get :register,                  to: 'users#new',                             as: :register
  post :register,                 to: 'users#create',                          as: :register
