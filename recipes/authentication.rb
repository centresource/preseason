# authlogic/devise
if @template_options[:authlogic]
  generate 'model user email:string crypted_password:string password_salt:string persistence_token:string perishable_token:string current_login_at:datetime last_login_at:datetime last_request_at:datetime login_count:integer last_login_ip:string current_login_ip:string'

  generate 'authlogic:session UserSession'

  insert_into_file 'app/models/user.rb', :before => 'end' do
  <<-AUTHLOGIC

  acts_as_authentic do |c|
    # because RSpec has problems with Authlogic's session maintenance
    # see https://github.com/binarylogic/authlogic/issues/262#issuecomment-1804988
    c.maintain_sessions = false
  end
  AUTHLOGIC
  end

  insert_into_file 'config/routes.rb', :before => 'end' do
  <<-ROUTES

  match '/login',                 :to => 'user_session#new',                      :as => :login,           :via => :get
  match '/login',                 :to => 'user_session#create',                   :as => :login,           :via => :post
  match '/logout',                :to => 'user_session#destroy',                  :as => :logout,          :via => :delete
  match '/forgot_password',       :to => 'user_session#forgot_password',          :as => :forgot_password, :via => :get
  match '/forgot_password',       :to => 'user_session#send_reset_password_link', :as => :forgot_password, :via => :post
  match '/reset_password/:token', :to => 'user_session#acquire_password',         :as => :reset_password,  :via => :get
  match '/reset_password/:token', :to => 'user_session#reset_password',           :as => :reset_password,  :via => :post
  match '/register',              :to => 'users#new',                             :as => :register,        :via => :get
  match '/register',              :to => 'users#create',                          :as => :register,        :via => :post
  ROUTES
  end

  create_file 'app/controllers/user_session_controller.rb', <<-AUTHLOGIC
class UserSessionController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      redirect_to root_url
    else
      flash.now[:error] = 'Username or password are incorrect.'
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_url
  end
end
  AUTHLOGIC
elsif @template_options[:devise]
  generate 'devise:install' unless @template_options[:active_admin]
  generate 'devise', 'user'
end