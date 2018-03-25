class SessionsController < ApplicationController
    
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to users_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out 
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end
  
  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)
    if User.find_by(email: auth_hash.info.email)
      @user = User.find_by(email: auth_hash.info.email)
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    else
      @user = User.from_omniauth(auth_hash)    # )(authentication, auth_hash)
      @next = edit_user_path(@user)
      @notice = "User created. Please confirm or edit details"
    end
    log_in @user
    redirect_to @next, :notice => @notice
  end

end
