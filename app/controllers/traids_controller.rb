class TraidsController < ApplicationController
  include SessionsHelper
  
  before_action :set_traid, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :validate_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @traids = Traid.where(key: @traid.key)
  end

  def new
    @traid = Traid.new
  end

  def edit
  end

  def create
    @traid = current_user.traids.new(traid_params)

    respond_to do |format|
      if @traid.save
        format.html { redirect_to @traid, notice: 'Traid was successfully created.' }
        format.json { render :show, status: :created, location: @traid }
      else
        format.html { render :new }
        format.json { render json: @traid.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @traid.update(traid_params)
        format.html { redirect_to @traid, notice: 'Traid was successfully updated.' }
        format.json { render :show, status: :ok, location: @traid }
      else
        format.html { render :edit }
        format.json { render json: @traid.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @traid.destroy
    respond_to do |format|
      format.html { redirect_to traids_url, notice: 'Traid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_traid
      @traid = Traid.find(params[:id])
    end

    def traid_params
      params.require(:traid).permit(:title, :conditions, :offer, :offer_type, :offer_subtype, :quantity)
    end
    
    def require_login
      if !logged_in?
        flash[:danger] = "You must be logged in to do that."
        redirect_to root_url
      end
    end
    
    def validate_user
      if !current_user.traids.include?(Traid.find(params[:id]))
        flash[:danger] = "You must be logged in to do that."
        redirect_to root_url
      end
    end
        
end
