class UserSessionController < ApplicationController
  before_filter :find_user_by_perishable_token, :only => [:acquire_password, :reset_password]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      redirect_back_or_default root_url
    else
      flash.now[:error] = 'Username or password are incorrect.'
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_url
  end

  def send_reset_password_link
    @user = User.where('LOWER(email) = ?', params[:email].downcase).first
    if @user.blank?
      flash.now[:error] = "No user found with that email address."
      render :forgot_password
    else
      begin
        @user.send_password_reset_instructions!
      rescue Net::SMTPFatalError
      end
      flash[:notice] = "An email has been sent with a link to reset your password. Please check your inbox."
      redirect_to root_url
    end
  end

  def reset_password
    if @user.update_attributes(params[:user])
      flash[:success] = "Your password has been changed. Please login to continue."
      redirect_to root_url
    else
      flash.now[:error] = "There was an error updating your password."
      render :acquire_password
    end
  end

  private
    def find_user_by_perishable_token
      @user = User.find_by_perishable_token(params[:token])

      if @user.blank?
        flash[:error] = "There was a problem finding your account. The reset password link may have expired. Please try again."
        redirect_to forgot_password_url
      end
    end
end
