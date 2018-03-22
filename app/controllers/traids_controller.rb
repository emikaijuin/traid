class TraidsController < ApplicationController
  before_action :set_traid, only: [:show, :edit, :update, :destroy]

  def index
    @traids = Traid.all
  end

  def show
  end

  def new
    @traid = Traid.new
  end

  def edit
  end

  def create
    @traid = Traid.new(traid_params)

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
      params.fetch(:traid, {})
    end
end
