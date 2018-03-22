class TraidLogsController < ApplicationController
  before_action :set_traid_log, only: [:show, :edit, :update, :destroy]

  # GET /traid_logs
  # GET /traid_logs.json
  def index
    @traid_logs = TraidLog.all
  end

  # GET /traid_logs/1
  # GET /traid_logs/1.json
  def show
  end

  # GET /traid_logs/new
  def new
    @traid_log = TraidLog.new
  end

  # GET /traid_logs/1/edit
  def edit
  end

  # POST /traid_logs
  # POST /traid_logs.json
  def create
    @traid_log = TraidLog.new(traid_log_params)

    respond_to do |format|
      if @traid_log.save
        format.html { redirect_to @traid_log, notice: 'Traid log was successfully created.' }
        format.json { render :show, status: :created, location: @traid_log }
      else
        format.html { render :new }
        format.json { render json: @traid_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /traid_logs/1
  # PATCH/PUT /traid_logs/1.json
  def update
    respond_to do |format|
      if @traid_log.update(traid_log_params)
        format.html { redirect_to @traid_log, notice: 'Traid log was successfully updated.' }
        format.json { render :show, status: :ok, location: @traid_log }
      else
        format.html { render :edit }
        format.json { render json: @traid_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traid_logs/1
  # DELETE /traid_logs/1.json
  def destroy
    @traid_log.destroy
    respond_to do |format|
      format.html { redirect_to traid_logs_url, notice: 'Traid log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_traid_log
      @traid_log = TraidLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def traid_log_params
      params.fetch(:traid_log, {})
    end
end
