class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end
  
  def create
    if params[:password] == params[:password_confirmation]
      @user = User.new(user_params)
      
      if @user.save
        flash[:notice] = "Welcome to Traid, #{@user.first_name}!"
        redirect_to users_path
      else
        flash[:notice] = "Sorry, there was an error creating your profile, please try again."
        render :new
      end
    end
  end
      
  private 
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :birthday, :email, :phone_number, :password, :password_confirmation, :address, :secondary_address, :city, :state, :country)
  end
end
