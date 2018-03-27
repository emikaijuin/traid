class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :validate_user, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @traids = Traid.where(user_id: @user.id)
  end

  def show
    @user = User.find(params[:id])
    @review = Review.new
    @traid = Traid.new
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.is_seeking = params[:user][:is_seeking].split(",") if @user.is_seeking != params[:user][:is_seeking].split(",")
    @user.is_offering = params[:user][:is_offering].split(",") if @user.is_offering != params[:user][:is_offering].split(",")
    
    if params[:password] == params[:password_confirmation]
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @user.update_attributes(user_params)
    @user.is_seeking = params[:user][:is_seeking].split(",") if @user.is_seeking != params[:user][:is_seeking].split(",")
    @user.is_offering = params[:user][:is_offering].split(",") if @user.is_offering != params[:user][:is_offering].split(",")
    
    respond_to do |format|
      if @user.save(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      # is_seeking = params[:user][:is_seeking].split(",")
      # is_offering = params[:user][:is_offering].split(",")
      params.require(:user).permit(:first_name, :last_name, :username, :birthday, :email, :phone_number, :password, :password_confirmation, :address, :secondary_address, :city, :state, :country, :is_offering, :is_seeking)
    end
    
    def require_login
      if !logged_in?
        redirect_to root_url
      end
    end
    
    def validate_user
      if current_user != User.find(params[:id])
        redirect_to root_url
      end
    end
    
end