class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.new(user_params)

    if @user.save!
      redirect_to users_url(@user)
    else 
      puts @user.errors.full_messages
      render :new
    end
  end

private

  def user_params
    params.require(:email).permit(:password)
  end
end