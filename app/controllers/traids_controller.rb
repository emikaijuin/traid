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
    @traid_logs = TraidLog.find_by(key: @traid.key)
  end

  def new
    @traid = Traid.new
  end

  def edit
  end

  def create
    @traid_1 = current_user.traids.new(traid_params)
    @traid_1.status = "requested"
    @traid_2 = Traid.create_copy(params[:traid_user_id], @traid_1.key, traid_params) if @traid_1.save
    respond_to do |format|
      if @traid_2.save
        TraidLog.add_traid_to_log(@traid_2.key)
        Notification.create(text: "You have received a new traid offer!", user_id: User.find(params[:traid_user_id]).id, traid_id: @traid_2.id)
        format.html { redirect_to @traid_1, notice: "Traid was sent to #{@user_2} (ID: #{@traid_1.key})" }
        # format.json { render :show, status: :created, location: @traid }
        format.js 
      else
        format.html { render :new }
        format.json { render json: @traid.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      if @traid.update(traid_params) && @traid.negotiating!
        Notification.create(text: "You have a counter-offer on one of your traids.", traid_id: @traid.id, user_id: User.find(params[:requested_user_id]).id)
        TraidLog.add_traid_to_log(@traid.key)
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
  
  def accept
    @accepted_traid = Traid.find(params[:accepted_traid_id])
    @accepter_traid = Traid.find(params[:accepter_traid_id])
    
    @accepter_traid.conditions = @accepted_traid.conditions
    
    [@accepted_traid, @accepter_traid].each do |traid|
      traid.is_reviewable_by_user = true
      traid.finalized!
    end
    
    if @accepted_traid.save && @accepter_traid.save
      Notification.create(text: "Your traid has been accepted!", user_id: @accepted_traid.user_id, traid_id: @accepted_traid.id)
      redirect_to traid_path(@accepter_traid)
    else
      flash[:notice] = "There was a problem, please try again."
      redirect_to traid_path(@accepter_traid)
    end
    
  end
  
  def cancel
    @canceler_traid = Traid.find(params[:canceler_traid_id])
    @canceled_traid = Traid.find(params[:canceled_traid_id])
    
    [@canceler_traid, @canceled_traid].each do |traid|
      traid.canceled!
    end
    
    if @canceled_traid.save && @canceler_traid.save
      Notification.create(text: "Your traid was canceled.", user_id: @canceled_traid.user_id, traid_id: @canceled_traid.id)
      redirect_to traid_path(@canceler_traid)
    else
      flash[:notice] = "There was a problem, please try again."
      redirect_to traid_path(@canceler_traid)
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
