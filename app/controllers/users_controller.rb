class UsersController < ApplicationController
    
  def new
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :birthday, :email, :phone_number, :encrypted_password, :address, :secondary_address, :city, :state, :country)
  end
end
