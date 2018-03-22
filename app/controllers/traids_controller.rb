class TraidsController < ApplicationController
  include SessionsHelper
  
  before_action :set_traid, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :redirect_user_to_their_traid_version_show_page, only: :show
  before_action :validate_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    traids = Traid.where(key: @traid.key)
    traids.each do |traid|
      @current_user_traid = traid if traid.user_id == current_user.id
      @requested_user_traid = traid if traid.user_id != current_user.id
    end
  end

  def new
    @traid = Traid.new
  end

  def edit
  end

  def create
    @traid_1 = current_user.traids.new(traid_params)
    @trade_1.status = "Requested"
    @traid_2 = Traid.create_copy(params[:traid_user_id], @traid_1.key) if @traid_1.save

    respond_to do |format|
      if @traid_2.save
        format.html { redirect_to @traid_1, notice: "Traid was sent to #{@user_2} (ID: #{@traid_1.key})" }
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
      params.require(:traid).permit(:title, :conditions, :offer, :offer_type, :offer_subtype, :quantity, :traid_user_id)
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
    
    def redirect_user_to_their_traid_version_show_page
      if @traid.user_id != current_user.id && !Traid.where(key: @traid.key, user_id: current_user.id).empty?
        redirect_to traid_path(Traid.find_by(key: @traid.key, user_id: current_user.id))
      elsif @traid.user_id != current_user.id && Traid.where(key: @traid.key, user_id: current_user.id).empty?
        redirect_to root_url
      end
    end    
    
end
