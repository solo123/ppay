class ImpLogsController < ApplicationController
  before_action :set_imp_log, only: [:show, :edit, :update, :destroy]

  # GET /imp_logs
  # GET /imp_logs.json
  def index
    @q = ImpLog.ransack(params[:q])
    @imp_logs = @q.result(distinct: true).page(params[:page])
  end

  # GET /imp_logs/1
  # GET /imp_logs/1.json
  def show
  end

  # GET /imp_logs/new
  def new
    @imp_log = ImpLog.new
  end

  # GET /imp_logs/1/edit
  def edit
  end

  # POST /imp_logs
  # POST /imp_logs.json
  def create
    @imp_log = ImpLog.new(imp_log_params)

    respond_to do |format|
      if @imp_log.save
        format.html { redirect_to @imp_log, notice: 'Imp log was successfully created.' }
        format.json { render :show, status: :created, location: @imp_log }
      else
        format.html { render :new }
        format.json { render json: @imp_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /imp_logs/1
  # PATCH/PUT /imp_logs/1.json
  def update
    respond_to do |format|
      if @imp_log.update(imp_log_params)
        format.html { redirect_to @imp_log, notice: 'Imp log was successfully updated.' }
        format.json { render :show, status: :ok, location: @imp_log }
      else
        format.html { render :edit }
        format.json { render json: @imp_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imp_logs/1
  # DELETE /imp_logs/1.json
  def destroy
    @imp_log.destroy
    respond_to do |format|
      format.html { redirect_to imp_logs_url, notice: 'Imp log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_imp_log
      @imp_log = ImpLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def imp_log_params
      params[:imp_log]
    end
end
