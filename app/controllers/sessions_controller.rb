class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:email][:password], params[:user][:password])

    if @user
      login(user)
      session[:session_token] = @user.reset_session_token!
      redirect_to users_url(@user)
    else
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end